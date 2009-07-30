From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Thu, 30 Jul 2009 01:31:28 -0700 (PDT)
Message-ID: <m3r5vy1siq.fsf@localhost.localdomain>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Jul 30 10:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWR3C-00086v-Jd
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZG3Ibc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 04:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZG3Ibc
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:31:32 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47747 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbZG3Iba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 04:31:30 -0400
Received: by bwz19 with SMTP id 19so437107bwz.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yS+b6le7XbvccxofzsLE5fA4gDN7NTXxw+ztPRDxfqw=;
        b=aHCFb8QjvSjxCXSFp4aTqxlQE4XokVuwJpgugx2WK5nSoRtWv0TPQ3BuR7uzCy3sH4
         7gC0Hv09zN2tETf0uOab80Lit7DnYVskhxrEfYZyJzQcy6PpZhS6zh1gF+/fVfa/oADY
         ODlM00iPCdN/Eq5IszM9KOzfuRTDQtvR7OOBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Bp69x4bop8K2bxhsHPKD3DSQiyVhNXpuR/+S1dHTUBnJ/6a6UBfybHmIu33EFD4S7p
         kuX8PI7hPuR1fJaxid6zmhfbS3iQEgnB66nAE9N3QrUvRHefP3ERNmrhNJABnw+DDqfO
         5w6KdbP9hRW832647CxwIOJSgB4Bgy+fJXW0w=
Received: by 10.204.53.72 with SMTP id l8mr759920bkg.171.1248942689301;
        Thu, 30 Jul 2009 01:31:29 -0700 (PDT)
Received: from localhost.localdomain (abvq124.neoplus.adsl.tpnet.pl [83.8.214.124])
        by mx.google.com with ESMTPS id d13sm4007254fka.2.2009.07.30.01.31.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 01:31:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6U8VQ5Y003137;
	Thu, 30 Jul 2009 10:31:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6U8VPrj003134;
	Thu, 30 Jul 2009 10:31:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124453>

Mark A Rada <marada@uwaterloo.ca> writes:

> I thought I would submit this little patch I made to my gitweb. I am
> on a relatively slow connection, and so LZMA compression time is
> less of a concern than bandwidth---I'm guessing that I am not the
> only person who suffers from slow internet connection syndrome.

First, Documentation/SubmittingPatches states that we prefer inline
patches, with additional comments (like the one above) either between
"---\n" line and diffstat, or like I did here before patch with patch
separated by comment by e.g. "-- >8 --\n" (scissors) line.

If posting patch inline isn't possible, and you have to use
attachement (for example because mailer you use wraps lines), please
at least use 'text/plain' mimetype so patch can be viewed without need
to save it in separate file (this might require changing suffix from
'.patch' to '.txt').


Second, if you are using 'txz' as internal name for new snapshot
format, why not use 'XZ utils' instead of 'LZMA Utils', and use
'display' => 'txz', 'type' => 'application/x-xz' and 
'suffix' => '.txz' (BTW. shouldn't suffix in your case be '.tar.lzma'
and not only '.lzma'?) and of course 'compressor' => ['xz']?


BTW. I wonder if it would be good idea to add support for this format
directly to git-archive...  OTOH it would mean additional dependency.

-- 
Jakub Narebski
Git User's Survey 2009: http://tinyurl.com/GitSurvey2009

-- >8 --
From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] Add Gitweb support for LZMA compressed snapshots

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 38492d0..e131ea4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -184,6 +184,13 @@ our %known_snapshot_formats = (
 		'format' => 'tar',
 		'compressor' => ['bzip2']},
 
+	'txz' => {
+		'display' => 'tar.lzma',
+		'type' => 'application/x-lzma',
+		'suffix' => '.lzma',
+		'format' => 'tar',
+		'compressor' => ['lzma']},
+
 	'zip' => {
 		'display' => 'zip',
 		'type' => 'application/x-zip',
@@ -196,6 +203,7 @@ our %known_snapshot_formats = (
 our %known_snapshot_format_aliases = (
 	'gzip'  => 'tgz',
 	'bzip2' => 'tbz2',
+	'lzma'  => 'txz',
 
 	# backward compatibility: legacy gitweb config support
 	'x-gzip' => undef, 'gz' => undef,
-- 
1.6.4
