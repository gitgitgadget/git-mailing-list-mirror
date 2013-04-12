From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH] help: mark common_guides[] as translatable
Date: Fri, 12 Apr 2013 15:51:42 +0200
Message-ID: <20130412135142.GA29454@ruderich.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 15:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQeOO-0004GP-4M
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 15:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab3DLNvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 09:51:47 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:41694 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab3DLNvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 09:51:46 -0400
Received: from localhost (p54B5EE3B.dip.t-dialin.net [::ffff:84.181.238.59])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Fri, 12 Apr 2013 15:51:45 +0200
  id 000000000000004C.0000000051681171.0000409D
Content-Disposition: inline
In-Reply-To: <1364942392-576-5-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220979>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
On Tue, Apr 02, 2013 at 11:39:51PM +0100, Philip Oakley wrote:
> --- a/help.c
> +++ b/help.c
> @@ -240,6 +241,23 @@ void list_common_cmds_help(void)
>  	}
>  }
>
> +void list_common_guides_help(void)
> +{
> +	int i, longest = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> +		if (longest < strlen(common_guides[i].name))
> +			longest = strlen(common_guides[i].name);
> +	}
> +
> +	puts(_("The common Git guides are:\n"));
> +	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> +		printf("   %s   ", common_guides[i].name);
> +		mput_char(' ', longest - strlen(common_guides[i].name));
> +		puts(_(common_guides[i].help));

common_guides[] is used here, but without N_() not picked up by
xgettext when creating the pot file.

Regards
Simon

 builtin/help.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 034c36c..062957f 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -419,13 +419,13 @@ static struct {
 	const char *name;
 	const char *help;
 } common_guides[] = {
-	{ "attributes", "Defining attributes per path" },
-	{ "glossary", "A Git glossary" },
-	{ "ignore", "Specifies intentionally untracked files to ignore" },
-	{ "modules", "Defining submodule properties" },
-	{ "revisions", "Specifying revisions and ranges for Git" },
-	{ "tutorial", "A tutorial introduction to Git (for version 1.5.1 or newer)" },
-	{ "workflows", "An overview of recommended workflows with Git"},
+	{ "attributes", N_("Defining attributes per path") },
+	{ "glossary", N_("A Git glossary") },
+	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
+	{ "modules", N_("Defining submodule properties") },
+	{ "revisions", N_("Specifying revisions and ranges for Git") },
+	{ "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 or newer)") },
+	{ "workflows", N_("An overview of recommended workflows with Git") },
 };
 
 static void list_common_guides_help(void)
-- 
1.8.2.481.g0d034d4

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
