From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] add: introduce add.ignoreerrors synonym for add.ignore-errors
Date: Wed, 1 Dec 2010 12:36:15 -0600
Message-ID: <20101201183615.GA27024@burratino>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <20101201175517.GA7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 19:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrXb-0008Ju-PN
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0LASg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:36:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50572 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab0LASg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:36:26 -0500
Received: by ywl5 with SMTP id 5so3613139ywl.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X41yudGqRiKAuaKAOgeRBJ+B3yMadBrrBC6OAkwylEM=;
        b=LBcHSnq6y65sMq614neM5JmdyCCEiyrFPnyd77NbfGGgDDwVhgaQgDAXtnhMSvgSlt
         XOSRcadqzPNmDsSLBt6MLQbcsaQYxdeevkFd90nIi+Y7B3KxuCKQOfS2qiNG3cCBQbiR
         /gxgjAjFhp//pYUxZAbRB+8oY4NQ01UlkvO3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j+JFOnJ7wuZPijoYrWA8AVEplvgux3sdNvLMf/95S1rCHw/WljD7Uu0z/8MPc2IbDg
         X8CeBkawi3As2GMOeAEGnGkRSLktMK52myO265cWlfxqsysIbksuCAF1SxXX27efmO0W
         gqJ9iiyzcfmkBYk9B2Ia3GpVPO1SeYI3GPrYY=
Received: by 10.231.30.68 with SMTP id t4mr9369913ibc.129.1291228584495;
        Wed, 01 Dec 2010 10:36:24 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id gy41sm163116ibb.5.2010.12.01.10.36.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 10:36:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201175517.GA7774@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162568>

The "[add] ignore-errors" tweakable introduced by v1.5.6-rc0~30^2 (Add
a config option to ignore errors for git-add, 2008-05-12) does not
follow the usual convention for naming values in the git configuration
file.

What convention?  Glad you asked.

	The section name indicates the affected subsystem.

	The subsection name, if any, indicates which of
	an unbound set of things to set the value for.

	The variable name describes the effect of tweaking
	this knob.

	The section and variable names can be broken into
	words using bumpyCaps in documentation as a hint to
	the reader.  These word breaks are not significant
	at the level of code, since the section and variable
	names are not case sensitive.

The name "add.ignore-errors" includes a dash, meaning a naive
configuration file like

	[add]
		ignoreerrors

does not have any effect.  Avoid such confusion by renaming to the
more consistent add.ignoreErrors, but keep the old version for
backwards compatibility.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:
> On Wed, Dec 01, 2010 at 10:34:06AM -0600, Jonathan Nieder wrote:

>> (+cc: Jeff, config parsing wizard)
>
> Ugh, that is not a title that I aspire to. :)

Yes, one day the code will be clean enough that wizardry is not
needed. :)

[...]
> But if you require --strip-dashes, then you get potentially differing
> behavior for the same set of options (i.e., one tool may accept "foobar"
> but the other requires "foo-bar", because the latter has not been
> updated to --strip-dashes).

It was a bad idea, so let's do the simple thing.  Like this?

 Documentation/config.txt |    1 +
 builtin/add.c            |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a6c0b5..c609de4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -553,6 +553,7 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+add.ignoreErrors::
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/builtin/add.c b/builtin/add.c
index 71f9b04..21dc1f7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -331,7 +331,8 @@ static struct option builtin_add_options[] = {
 
 static int add_config(const char *var, const char *value, void *cb)
 {
-	if (!strcasecmp(var, "add.ignore-errors")) {
+	if (!strcasecmp(var, "add.ignoreerrors") ||
+	    !strcasecmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
-- 
1.7.2.3
