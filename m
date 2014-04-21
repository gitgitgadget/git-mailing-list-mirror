From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v4 1/2] add: add --ignore-submodules[=<when>] parameter
Date: Mon, 21 Apr 2014 23:19:34 +0200
Message-ID: <53558B66.3080602@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com> <5349C226.9090709@gmail.com> <5351123A.9060201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLcj-0005S3-4a
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbaDUVT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:19:29 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:45361 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbaDUVT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:19:28 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3906835eek.37
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7+GEKXiDNZyk2jmyoqZHqx4TCHqY2Sgwdl/8yGa3wxM=;
        b=m4dLPwAMBzuvXFOgTEoLlp1IqqdeTx2gv+k1dYZlL5oane6Tds5JH4CAg8XC5V4Uqx
         tYrKRnNtsJw4wz6CvhQm3vtJ0Xc0N3Ax6nCOxcqVhk2HqFxShHhiafOAUHlCTdBK5OBV
         zE5P6aVaJyjbqJNBxkFdI8q6R0ICo89gin0krabEhCvLaIdTpW2kbcSBBM6yD1KOE+5E
         1AoFZ3/xJ+Junptm4D23Hdg0mQlcb9EZz8CfakVbK8Vo+RiunYbbSUak3jHD3FhaT/A5
         c6Gdb5pITnT2sl3CJHo636/D/5mXPoc4mhS6+4GZsycleEXjLr/YfpDV4edODoQFulV1
         KkOw==
X-Received: by 10.15.54.137 with SMTP id t9mr50282330eew.39.1398115166801;
        Mon, 21 Apr 2014 14:19:26 -0700 (PDT)
Received: from [10.0.1.226] ([212.144.56.68])
        by mx.google.com with ESMTPSA id w46sm3521144eeo.35.2014.04.21.14.19.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 14:19:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5351123A.9060201@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246642>

On 18. 4. 2014 13:53, Jens Lehmann wrote:
> Am 13.04.2014 00:45, schrieb Ronald Weiss:
>> Allow ignoring submodules (or not) by command line switch, like diff
>> and status do.
>>
>> Git add currently doesn't honor ignore from .gitmodules or .git/config,
>> which is related functionality, however I'd like to change that in
>> another patch, coming soon.
> 
> I think we should drop this paragraph from this commit message. Though
> I believe it's helpful to add this information after the "---" below
> to inform readers of the list of your future plans.
> 
>> This commit is also a prerequisite for the next one in series, which
>> adds the --ignore-submodules switch to git commit.
> 
> But this information definitely belongs here.
> 
>> That's why signature
>> of function add_files_to_cache was changed.
> 
> But that's necessary for this patch too, no?

No, for this patch alone, we could just use the global variable, which
is set up by parse_options(), without changing the public function and
breaking compilation in other files.

> 
>> That also requires compilo fixes in checkout.c and commit.c
> 
> Sorry, but I don't know what a "compilo fix" is ;-) .. I suspect you
> mean that add_files_to_cache() needs a new NULL argument in some
> places. What about dropping the last two sentences and adding
> something like "Add a new argument to add_files_to_cache() to pass
> the command line option and update all other call sites to pass
> NULL instead." to the first paragraph?
> 
> Apart from that and the flags of the test (see below) this patch
> is looking good to me.

OK, I'll update the commit message, and fix the file mode for the added
test script. Will repost once we sort out the problems (failing tests)
You have with the second patch (for commit).

>> diff --git a/t/t3704-add-ignore-submodules.sh b/t/t3704-add-ignore-submodules.sh
>> new file mode 100644
> 
> The flags should be 100755 here, currently "make test" fails because
> of this.

I'm sorry for this, I was testing it on Windows, where the file mode
doesn't matter, that's why I missed it.
