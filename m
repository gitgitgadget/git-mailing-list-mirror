From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Fri, 30 Jan 2015 18:40:17 -0800
Message-ID: <a924a58108ea8ad8aece1ee66cbdc3f@74d39fa044aa309eaea14b9f57fe79c>
References: <54CA3611.1000804@statsbiblioteket.dk> <1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk> <20150130230516.GA7867@vauxhall.crustytoothpaste.net>
Cc: Git mailing list <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 03:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHNz9-0006gA-Uz
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 03:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbbAaCkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 21:40:24 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:45947 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbbAaCkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 21:40:23 -0500
Received: by mail-pa0-f54.google.com with SMTP id eu11so59318634pac.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 18:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwmySS3zInYZRgyXBxtWxGHzC1F1EmMDeltIH8V3WRo=;
        b=aCXgo+gkfxPIVLQw6RYDy+ihbEGoVGbSq2Z4OG05iJJP4LVERmyc5HElO2DWAPc75V
         Rq5LhD2ciN/lmRTxXv5Ymxek7/FS3Xcwicv5vqAmmaMkMcWUSp1g7cX1dIa9mmBwWoy8
         Tm6dLEdgFokEq/+Dfs3HXcNK6L5E03pyu4l1DqdV8vvtNBNUYFxa3uJUbi+npsjAtLAv
         QakDX8qR9wmKU5YP4JSGFsd4Xx3vBzlQzqoRLRxJ3d6QyjcapgBmpJn9iRiYaqdmveSw
         /nF3nT3QweFXKrBOXngFDqjp9m//hGndgbVql/SAgtEPeWb8q0m0DaISG45sHOni3bYM
         FcUQ==
X-Received: by 10.68.125.197 with SMTP id ms5mr13468061pbb.12.1422672023082;
        Fri, 30 Jan 2015 18:40:23 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id co9sm12045667pdb.69.2015.01.30.18.40.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 Jan 2015 18:40:22 -0800 (PST)
In-Reply-To: <20150130230516.GA7867@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263203>

On Jan 30, 2015, at 15:05, brian m. carlson wrote:
> On Fri, Jan 30, 2015 at 07:24:45AM +0100, Tom G. Christensen wrote:
>> The '--no-xmailer' option is a Getopt::Long boolean option. The
>> '--no-' prefix (as in --no-xmailer) for boolean options is not
>> supported in Getopt::Long version 2.32 which was released with Perl  
>> 5.8.0.
>> This version only supports '--no' as in '--noxmailer'.  More recent
>> versions of Getopt::Long, such as version 2.34, support either  
>> prefix. So
>> use the older form in the tests.
>>
>> See also:
>>
>> d2559f734bba7fe5257720356a92f3b7a5b0d37c
>> 907a0b1e04ea31cb368e9422df93d8ebb0187914
>> 84eeb687de7a6c7c42af3fb51b176e0f412a979e
>> 3fee1fe87144360a1913eab86af9ad136c810076
>>
>> Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
>> ---
>> t/t9001-send-email.sh | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index af6a3e8..30df6ae 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -1580,20 +1580,20 @@ do_xmailer_test () {
>>
>> test_expect_success $PREREQ '--[no-]xmailer without any  
>> configuration' '
>> 	do_xmailer_test 1 "--xmailer" &&
>> -	do_xmailer_test 0 "--no-xmailer"
>> +	do_xmailer_test 0 "--noxmailer"
>
> I don't think this is an adequate fix.  The documented option is -- 
> no-xmailer.  If your version of Getopt::Long is not capable of that,  
> then the program doesn't work as documented, and the test is  
> correctly failing.  --noxmailer is not documented at all, so it's  
> not something we should be testing.

It is not alone.  From the git-send-email help these are all boolean  
options:

> git send-email
>
>   Composing:
>     --[no-]xmailer
>     --[no-]annotate
>
>   Automating:
>     --[no-]cc-cover
>     --[no-]to-cover
>     --[no-]signed-off-by-cc
>     --[no-]suppress-from
>     --[no-]chain-reply-to
>     --[no-]thread
>
>   Administering:
>     --[no-]validate
>     --[no-]format-patch


Anything done to fix --no-xmailer should be applied for all the other  
--no-... options as well.

> We should probably require a certain version of Getopt::Long or  
> explicitly handle this in the parsing code itself.  I think the  
> former is a better choice, since no security-supported OS still  
> ships with such a positively ancient version.

I don't really like that second option because all the .perl files have:

> use 5.008;

So either that needs to change or the code should properly deal with  
the version of Getopt::Long that comes with 5.8.0.

Since it's really not very difficult or invasive to add support for  
the no- variants, here's a patch to do so:

-- 8< --
Subject: [PATCH] git-send-email.perl: support no- prefix with older GetOptions

Only Perl version 5.8.0 or later is required, but that comes with
an older Getopt::Long (2.32) that does not support the 'no-'
prefix.  Support for that was added in Getopt::Long version 2.33.

Since the help only mentions the 'no-' prefix and not the 'no'
prefix, add explicit support for the 'no-' prefix when running
with older GetOptions versions.

Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 git-send-email.perl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3092ab35..a18a7959 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -299,6 +299,7 @@ my $rc = GetOptions("h" => \$help,
 		    "bcc=s" => \@bcclist,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
+		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-option=s" => \@smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
@@ -311,25 +312,34 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
+		    "no-annotate" => sub {$annotate = 0},
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
+		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
 		    "cc-cover|cc-cover!" => \$cover_cc,
+		    "no-cc-cover" => sub {$cover_cc = 0},
 		    "to-cover|to-cover!" => \$cover_to,
+		    "no-to-cover" => sub {$cover_to = 0},
 		    "confirm=s" => \$confirm,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
+		    "no-thread" => sub {$thread = 0},
 		    "validate!" => \$validate,
+		    "no-validate" => sub {$validate = 0},
 		    "transfer-encoding=s" => \$target_xfer_encoding,
 		    "format-patch!" => \$format_patch,
+		    "no-format-patch" => sub {$format_patch = 0},
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
+		    "no-xmailer" => sub {$use_xmailer = 0},
 	 );
 
 usage() if $help;
--
