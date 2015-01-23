From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Thu, 22 Jan 2015 16:12:48 -0800
Message-ID: <7D660CE3-AC55-4A0A-B5D9-D76853F6817C@gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com> <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com> <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com> <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com> <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com> <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com> <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com> <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com> <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com> <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c> <CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com> <xmqq1tmnwypp.fsf@gitster.dls.corp.google.co
 m> <21FC5344-64BF-46B1-ADA9-DDE3B1FEC8C4@gmail.com> <xmqq7fwetya3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:13:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YERru-0007N0-Be
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 01:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbbAWAMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 19:12:53 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43880 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbbAWAMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 19:12:51 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so2204378pab.12
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=3lMqaks7s/DAVeVF6Iv5NUBebZIHVkQyRpIpWpJL8Zw=;
        b=mHnqPkHuasL4MwKxdwkTGHN/gF393PBxToCIN0P6TxqveL4hmsnYW3e4WBKcwGxmRl
         kCPk6ddEL9gCTFqKIK6QU5XxtUN1wIy3oHVid1Zj2nnxKammHMIM40Suhe6rGbPoe4G1
         fd/ioYXw6HA+K+vjtnuj0Re4AA7V5Bj+Pd+Msref7qbGmPUB0ZDvp/+rg7iZKu6K1cZW
         RSLI6S+ZqoolIEbH77DN5j+8r2PDRHyUeZfVpGLAJEHXOWDB+mfG8JTaSqRpZ+udSNrV
         yF/48mGneApNXuDM3EhsehNQj1zmDK3OrLVYu3vw/tLKH7d64ay3rSeVStbris3xKV7W
         LzeA==
X-Received: by 10.66.141.165 with SMTP id rp5mr6676071pab.102.1421971971243;
        Thu, 22 Jan 2015 16:12:51 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id di10sm5240907pad.41.2015.01.22.16.12.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 16:12:50 -0800 (PST)
In-Reply-To: <xmqq7fwetya3.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262896>

On Jan 22, 2015, at 11:23, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> On Jan 21, 2015, at 14:33, Junio C Hamano wrote:
>>
>>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>>
>>>> So since I've not been able to get test 2 or 3 to core dump (even
>>>> before 250b3c6c) I tend to believe you are correct in that the code
>>>> thinks (incorrectly) that the result should fit within the buffer.
>>>
>>> Thanks; let me steal your tests when I reroll.
>>
>> Awesome. :)
>>
>> But please squash in this tiny change if using the tests verbatim:
>
> Thanks.  I actually have a question wrt the need for $MAKE_PATCHES.
>
> It would have been more natural to do something like:
>
> test_expect_success 'setup' '
> 	printf "\t%s\n" 1 2 3 4 5 6 >before &&
> 	printf "\t%s\n" 1 2 3 >after &&
> 	printf "%64s\n" a b c >>after &&
> 	printf "\t%s\n" 4 5 6 >>after &&
> 	git diff --no-index before after |
> 	sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
> 	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
> 	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
>
> 	printf "\t%s\n" a b c d e f >before &&
> 	printf "\t%s\n" a b c >after &&
>        ...
> 	cat test-4 >expect-4 &&
> 	printf "%64s\n" a b c >>expect-4 &&
> 	while test $x -lt 100
> 	do
> 		printf "%63s%02d\n" "" $x >>test-4
> 		printf "%63s%02d\n" "" $x >>expect-4
> 		x=$(( $x + 1 ))
> 	done &&
>
> 	git config core.whitespace tab-in-indent,tabwidth=63 &&
>        git config apply.whitespace fix
> '
>
> test_expect_success 'apply with ws expansion (1)' '
> 	git apply patch1.patch &&
>        test_cmp test-1 expect-1
> '
>
> and if you want test files you can just skip tests #2 and later,
> without introducing an ad-hoc mechanism like you did.
>
> Was there something more than that that you wanted from
> $MAKE_PATCHES?

Well, see I found t/t4135/make-patches that makes patches for use by  
t4135-apply-weird-filenames.sh and thought perhaps that was the  
approved way to do things.

But then it seemed overkill since making the patches takes so little  
time it didn't seem to warrant a separate directory.  But the ability  
to just make the patch files without requiring any external scripts or  
test framework seemed nice so I added those two extra lines to make it  
possible.

I don't have any strong feelings about it.  The setup test plus 4  
explicit tests looks fine.

> In any case, here is an update to that sanity check patch to catch
> the two cases the BUG did not trigger.
>
> Sometimes the caller under-counted the size of the result but
> thought that it would still fit within the original (hence allowing
> us to update in-place by passing postlen==0) but the actual result
> was larger than the space we have allocated in the postimage,
> clobbering the piece of memory after the postimage->buf.
>
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 31f8733..3b7ba63 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2171,6 +2171,12 @@ static void update_pre_post_images(struct  
> image *preimage,
> 		ctx++;
> 	}
>
> +	if (postlen
> +	    ? postlen < new - postimage->buf
> +	    : postimage->len < new - postimage->buf)
> +		die("BUG: caller miscounted postlen: asked %d, orig = %d, used =  
> %d",
> +		    (int)postlen, (int) postimage->len, (int)(new - postimage- 
> >buf));
> +
> 	/* Fix the length of the whole thing */
> 	postimage->len = new - postimage->buf;
> 	postimage->nr -= reduced;

Nice.  No more of those bogus results can slip through that somehow  
evade evoking a core dump.

-Kyle
