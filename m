From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] grep: rip out support for external grep
Date: Wed, 13 Jan 2010 03:29:41 -0500
Message-ID: <76718491001130029i24a4edeyf72ce692429dffa6@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
	 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
	 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
	 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
	 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
	 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
	 <7v63774tfd.fsf@alter.siamese.dyndns.org>
	 <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 09:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUybq-0005tk-Ra
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab0AMI3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056Ab0AMI3n
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:29:43 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:43055 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab0AMI3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:29:42 -0500
Received: by iwn35 with SMTP id 35so16235028iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=eTbvjxQm8gGV2tR4+K99KpiG+ZzALp1aqfhoUF15YDU=;
        b=fazhVX59e9ff8mxJlQL9qa44yKqDFU4vCu8XMwVOQKCowpSrZdH4IwHAhJzcNpXK8X
         LKuN2qD8X5AnMLcG5cpKnN+wqafRq9LdLMM0YAHtwwxRtJekCFeHaqc8F4AD7tH25FNu
         QJWnZi2fHtx5RSfTH7bRzmC7/JTtui2XdYuSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=swQVJ1vAaH+wGW8ngkNp6UdMIwaS/0VnExnglDJxieCQd/zjFpWmf32NpgURrCNc0x
         Pi5vIyitJZ+wrPymlzkTj0FHqItKZSX7TFb4VV2kR5KqYg7NRPCOiTO5zXQVxnGDRY5l
         LuHiervLdUYYO9sQqTQu3Q/ET7ee87rNhrqug=
Received: by 10.231.122.139 with SMTP id l11mr871310ibr.53.1263371381516; Wed, 
	13 Jan 2010 00:29:41 -0800 (PST)
In-Reply-To: <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136790>

On Wed, Jan 13, 2010 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> We still allow people to pass --[no-]ext-grep on the command line,
> but the option is ignored.

Perhaps this squashed in on top? (If gmail's web-interface mangles
this I can resend.)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..6a96d9d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -645,14 +645,6 @@ color.grep::
        `never`), never.  When set to `true` or `auto`, use color only
        when the output is written to the terminal.  Defaults to `false`.

-color.grep.external::
-       The string value of this variable is passed to an external 'grep'
-       command as a command line option if match highlighting is turned
-       on.  If set to an empty string, no option is passed at all,
-       turning off coloring for external 'grep' calls; this is the default.
-       For GNU grep, set it to `--color=always` to highlight matches even
-       when a pager is used.
-
 color.grep.match::
        Use customized color for matches.  The value of this variable
        may be specified as in color.branch.<slot>.  It is passed using
diff --git a/builtin-grep.c b/builtin-grep.c
index 4adb971..3d6ebb5 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -34,8 +34,6 @@ static int grep_config(const char *var, const char
*value, void *cb)
                opt->color = git_config_colorbool(var, value, -1);
                return 0;
        }
-       if (!strcmp(var, "color.grep.external"))
-               return git_config_string(&(opt->color_external), var, value);
        if (!strcmp(var, "color.grep.match")) {
                if (!value)
                        return config_error_nonbool(var);
diff --git a/grep.h b/grep.h
index 75370f6..0c61b00 100644
--- a/grep.h
+++ b/grep.h
@@ -85,7 +85,6 @@ struct grep_opt {
        int max_depth;
        int funcname;
        char color_match[COLOR_MAXLEN];
-       const char *color_external;
        int regflags;
        unsigned pre_context;
        unsigned post_context;
