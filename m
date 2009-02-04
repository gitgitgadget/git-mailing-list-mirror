From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 17:03:22 +0200
Message-ID: <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <20090204145317.GA5712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjJ5-00058D-Fj
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbZBDPD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbZBDPDZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:03:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:5658 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBDPDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:03:24 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1254588fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IcWNVEwvwwJAtyykoOGXxc/N45AFgYJvnEzrD78F4Zw=;
        b=XdfEDeKzKnoa1sLMcJnfOwUb+tGYU84v2pgOkyjBi7pTimlS4nYFcJlqK5Kgf/k7Di
         4OjeVuouCS+8M4uzrRPNd0lxakQ5XJx55K9PsrqVslrMTYg7fiNXcB6Bhzhx2BVFjaPg
         gG9SN/if4THtq4CefFxcC482MsKBqvVv8CBR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iyhr1ElIredj9lZQH0DQbOkDk/q3QeBMJm4xjKTQi4JdtlrlbXFZzysTXmJZ89uM3+
         0X2NQ/3R0FtIQH4EgZHlBL5PE0wJCLW1Z3JFprd8iQBKKEDM8hle7m2kDxZQIzOvguoD
         iVq8R832YpMKdOjnsb71Yom4MOrt2ClpOIe0o=
Received: by 10.86.82.16 with SMTP id f16mr1734271fgb.26.1233759802635; Wed, 
	04 Feb 2009 07:03:22 -0800 (PST)
In-Reply-To: <20090204145317.GA5712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108374>

On Wed, Feb 4, 2009 at 4:53 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 04, 2009 at 12:40:26AM +0200, Felipe Contreras wrote:
>
>> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
>> +                     char *config_filename;
>> +                     if (config_exclusive_filename)
>> +                             config_filename = xstrdup(config_exclusive_filename);
>> +                     else
>> +                             config_filename = git_pathdup("config");
>> +                     launch_editor(config_filename, NULL, NULL);
>> +                     free(config_filename);
>> +                     return 0;
>>               } else
>
> With this patch, won't I get different behavior from:
>
>  git config -e --global
>
> versus
>
>  git config --global -e

Just like you get different behavior from:

git config -l --global

and

git config --global -l

-- 
Felipe Contreras
