From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 2/2] convert: ce_compare_data() checks for a sha1 of a
 path
Date: Wed, 18 May 2016 06:26:23 +0200
Message-ID: <573BEEEF.8040305@web.de>
References: <573A993F.8020205@web.de>
 <1463503301-3634-1-git-send-email-tboegi@web.de>
 <xmqq60ucwlz8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 06:26:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2t4H-00053U-0M
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 06:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbcERE0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 00:26:37 -0400
Received: from mout.web.de ([212.227.15.4]:59629 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbcERE0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 00:26:37 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LZeou-1bS04I2DZE-00lUSt; Wed, 18 May 2016 06:26:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqq60ucwlz8.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:C7dNTKJ+AWp5MqyTj0jgeWQROpeDwIqHf/bWCH7owuqe/k1+Od3
 JwR8GOhym+3cOtI5qEBhIEfCqNPrBOfnSqiU6Bkk7hLTroBL7qvlhdmzOlWLKvwKx73bWcG
 CoUpagKiWvmmPF8SnifLTRJofAAZyYoaChpPu08kqu4Ob65XeDaKyzARJFBqDW0e8mVcqeQ
 cV3gx9+2xpyCeWX0sJuRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:azcT7rLNTdk=:Fb3jKzF18fja8lVdV4fHXH
 iePZndX5J4/c/BaRGk+/LHBt7l/6sXC7A8x1FogJMwe9Abpmo78Pf+ouTN2Px5A0yES7sSt/P
 WySqeJhhmWzF9EiAfEt9eL58Z5a2RabxsO43hZQWA7j7mX7BH+RZZ3YCrgjrUCcJbENrsaDOk
 TJcQkK1bNyPvbtf/Ylfdy9xi7UgCAHVLowa4XCNn4lFqsXuqGgs/kX9uOgcB2BPEyntWknSgi
 6P6T4jRWa5re/kJxwCMFmmMRrR4dLWuQtNj5T6Q6p+8HiAydTNnFxUWpHrRkvOJRzBlbnLmUf
 1O0s69gDLFhDZmZZjfMnQq1dbg+V6agU4vzTxsgGXSFNs/OuFpXdFd2IbwlIJzleF4ss7f13j
 KGTaztipnqgW1c8B0kAkwMxbY5JXSoEmAXTfHk64FgUy1QrRTKoofgUY3Obxu6DRfxNm7xjkM
 QnPf1bMu+xmmngvB4esgkRYP2MqJNBcH6JGnl78QVb1WAhfTAcRZ/AgmWdUtETXGVCJoCYHW3
 7g9AE0r26JYvH7BXVFV9tMgMv175vCdiOti2XK/qYXLLd/oRgUGU8IumDvC9IcEtKG+xe8lyP
 s4T08m7blomBu51v6ogPtoSUjmt1MfzvgkDTN6ssoZMxA5nF+uoj2LyTQFASGhcssgMGml6Nd
 3jfwjEEkCNm5ZUO9E5zy7LA8cSHDLnRRTbPzAql9jCsthFDsmMjnb4hpoVVhgDzzkVxjmDJAD
 WEWpfs067bFJPg61YVzWAfZBe2Aeq5aSiv9nhackEfHSScURCmHcL2MIbKvTkVRH7YESwUDW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294932>

On 05/17/2016 08:58 PM, Junio C Hamano wrote:
> tboegi@web.de writes:
>
>>   #define HASH_WRITE_OBJECT 1
>>   #define HASH_FORMAT_CHECK 2
>> +#define HASH_CE_HAS_SHA1  4
>
> How does one pronounce the words in this constant?  Does it make a
> listener understand what this constant means?
How about
HASH_USE_SHA1_FROM_CE
or
HASH_CE_HAS_VALID_SHA1


>
>
> /*
>   * We need a comment around here to say what these two
>   * parameters mean.  I am guessing that (1) if sha1 is not NULL,
>   * path is ignored and the function inspects if it has CR; (2)
>   * otherwise it checks the index entry at path and inspects if
>   * it has CR.
>   */
>>
>> -static int has_cr_in_index(const char *path)
>> +static int has_cr_in_index(const char *path, const unsigned char *sha1)
>>   {
>
> This makes me seriously wonder if it is a good idea to modify this
> function like this.  (1) means this function is not about IN INDEX
> at all!
>
> Perhaps add a "static int blob_has_cr(const unsigned char *sha1)"
> and call it from the real caller you added that wants to call this
> butchered two-param version that has sha1 is a better solution?
>
>> -static int crlf_to_git(const char *path, const char *src, size_t len,
>> +static int crlf_to_git(const char *path, const unsigned char *sha1,
>> +		       const char *src, size_t len,
>>   		       struct strbuf *buf,
>>   		       enum crlf_action crlf_action, enum safe_crlf checksafe)
>>   {
>> @@ -260,7 +267,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>>   			 * If the file in the index has any CR in it, do not convert.
>>   			 * This is the new safer autocrlf handling.
>>   			 */
>> -			if (has_cr_in_index(path))
>> +			if (has_cr_in_index(path, sha1))

>
> I think this change is too ugly.  The new "sha1" parameter is
> telling us that "in order to see if the indexed version has CR, do
> not look at the index, but look at the contents of this blob".
Thanks for some fresh eyes, I guess that
blob_has_cr(sha1)
would make most sense.
