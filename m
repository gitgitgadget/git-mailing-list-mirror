From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 08/11] t6050-replace: check that -f option bypasses
 the type check
Date: Sun, 01 Sep 2013 12:02:28 +0200 (CEST)
Message-ID: <20130901.120228.1211524158553068971.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.37671.chriscool@tuxfamily.org>
	<CAPig+cTSTk7f+EwwwMZpNU5QsiU3_Nu92aQz1AsZ2bSGzEgcTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org,
	trast@inf.ethz.ch, j6t@kdbg.org
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sun Sep 01 12:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG4UP-0001hA-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 12:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab3IAKCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 06:02:34 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:54166 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596Ab3IAKCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 06:02:33 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 9A1AC36;
	Sun,  1 Sep 2013 12:02:30 +0200 (CEST)
In-Reply-To: <CAPig+cTSTk7f+EwwwMZpNU5QsiU3_Nu92aQz1AsZ2bSGzEgcTg@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233581>

From: Eric Sunshine <sunshine@sunshineco.com>
>
> On Sat, Aug 31, 2013 at 3:12 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  t/t6050-replace.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> index 05be228..0b07a0b 100755
>> --- a/t/t6050-replace.sh
>> +++ b/t/t6050-replace.sh
>> @@ -276,6 +276,12 @@ test_expect_success 'replaced and replacement objects must be of the same type'
>>         grep "$BLOB. points to a replacement object of type .blob" err
>>  '
>>
>> +test_expect_success '-f option bypasses the type check' '
>> +       git replace -f mytag $HASH1 2>err &&
>> +       git replace -f HEAD^{tree} HEAD~1 2>err &&
>> +       git replace -f HEAD^ $BLOB 2>err
>> +'
> 
> Is there a non-obvious reason you are redirecting stderr to a file in
> this test? Unlike the test added earlier, this one never consults the
> error output. By dropping this apparently unnecessary redirection,
> diagnosis of a regression potentially becomes simpler since any error
> output from git-replace will become visible when the test is run
> verbosely.

You are right! I will drop these redirections.

Thanks,
Christian.
