From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Sat, 13 Jul 2013 20:14:20 +0200
Message-ID: <51E198FC.5080005@googlemail.com>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com> <1373700020-30436-1-git-send-email-stefanbeller@googlemail.com> <7v8v1aicn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 20:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy4Ks-0004gb-T7
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825Ab3GMSOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 14:14:16 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:54699 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757659Ab3GMSOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 14:14:14 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so9081947wev.28
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=6we63oh5ksYYn7yqmOPOBNrZw+yxnWkIAPnuNGenZgo=;
        b=zM1VyzgIpM4Pr8g5maCCmcCrrrqeQDTbzbpVyWc8qlbImc8yKGNiffUoUYSGAA21HZ
         5VL1Z9VzowtA6b6/19lIX7vY81P+Cj2nmUtv3hfoVO+9i8toxfT3PQKy895HFeHoOxcP
         BhFis3TH0h/b6KMJut9DX4vdL40AlJ0ZuhFU/rQdqAezJ+iGPn10UxxWUxkklzpj7J+6
         o2ppE43t0u/MRRs6h6zaPeBk8C3VTZ/Tboy5zOwUvGfkkoHHANTwgQQDIQNXNDlgsoFi
         7Dmltf5YD2dtP5rFJk1L705MAz2+L8mygSnBiBj9v50L5peWruZid0O3vCVVIt6ErEy6
         IhmA==
X-Received: by 10.180.13.5 with SMTP id d5mr4603606wic.56.1373739253169;
        Sat, 13 Jul 2013 11:14:13 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id nb12sm10214264wic.7.2013.07.13.11.14.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 11:14:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v8v1aicn5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230285>

On 07/13/2013 07:38 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> This is a regression test for a66e77eab70a08938fdc2227b7ada0f0465c6991
> 
> Sorry, I do not quite get this.
> 
> If you apply the patch on top of the said commit before that commit, the
> new test does not pass.
> 
> But if you apply the patch on top of the said commit, the new test
> still does not pass.
> 
> So I am having hard time guessing what you meant by "regression
> test".  It is not "a66e77 broke something that ought to work, and
> this shows the breakage".  It is not "a66e77 fixed something and
> this shows the previous breakage that got fixed."
> 
> It may be because the test is depending on ShortName not to be
> downcased incorrectly, which was to be fixed by a later commit.  But
> after applying this on top of jc/mailmap-case-insensitivity topic,
> the test does not pass (and reverting a66e77 does not seem to affect
> the result, either).
> 

I am sorry for the bad wording, sorry for wasting your time.

This patch was meant to replace 134d1ac9be2ce97c60a7e9187c32980681811cb5
(current test, latest commit on mailmap-case-insensitivity)

Indeed the patch tests for both bugs unintentionally.
So both the one letter name is being used and the email
case sensitivity is checked.
So maybe I should redo it again and make 2 explicit test cases
for each of the fixes?

Stefan
