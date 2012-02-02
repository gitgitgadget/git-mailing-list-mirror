From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Wed, 1 Feb 2012 18:31:18 -0600
Message-ID: <20120202003118.GB3487@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120201233515.GC29599@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:31:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskaR-0004lB-72
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab2BBAbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 19:31:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59199 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2BBAbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 19:31:34 -0500
Received: by iacb35 with SMTP id b35so2246753iac.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T1gWg7kqXmPJIK6OX/Aqf9vaiKsNlb0astmLoEddyoA=;
        b=Ur+BrAJ1t6rSwAd2TM+q9hm6dmLLhqGlISAdMgv0aSyhsA7hP3kDWOtVqz1wk24RxF
         n363rpnPqp0FqQGdAPczqcgfBG935F4sBUDq/5+5OMDNhEsPLk6uK+7mhnnC1jvjrcVq
         LGoOKts+McsMq7b2rRA9i5tqAleC607e2Sok0=
Received: by 10.50.202.67 with SMTP id kg3mr931279igc.13.1328142693633;
        Wed, 01 Feb 2012 16:31:33 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm1261202ibl.6.2012.02.01.16.31.32
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 16:31:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120201233515.GC29599@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189563>

Jonathan Nieder wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>> --- a/t/t5150-request-pull.sh
>> +++ b/t/t5150-request-pull.sh
>> @@ -95,7 +95,7 @@ test_expect_success 'setup: two scripts for readin=
g pull requests' '
>>  	b
>>  	: diffstat
>>  	n
>> -	/ [0-9]* files changed/ {
>> +	/ [0-9]* files\? changed/ {
>
> Mimicking a human.
>
> (**) Should probably use "*" instead of \? --- \? is a GNU extension,
> not a BRE.

=2E.. and here's a patch making that change for convenience (also untes=
ted).
---
 t/t5150-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 34c482f1..ec5f7368 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -95,7 +95,7 @@ test_expect_success 'setup: two scripts for reading p=
ull requests' '
 	b
 	: diffstat
 	n
-	/ [0-9]* files\? changed/ {
+	/ [0-9]* files* changed/ {
 		a\\
 	DIFFSTAT
 		b
--=20
1.7.9
