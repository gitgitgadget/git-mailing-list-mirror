From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Clone repositories recursive with depth 1
Date: Thu, 12 Nov 2015 15:47:44 -0800
Message-ID: <CAGZ79kYNCWXVLWAzTCoFfuHGRkJzzUsojGzK9-f=543FVfVMAg@mail.gmail.com>
References: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
	<CAGZ79kbfFhCvQW=_7i4KxjWeh7uYRTTNvLzQUq+CJ641g3=UDg@mail.gmail.com>
	<CAGZ79kazAWj+D85EXUyP9iHgcb=7QpymyaaKEqQRu9a+UO9msw@mail.gmail.com>
	<19CE7136-E1FD-495A-9BAC-636164757E04@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>,
	Stanislav <s.seletskiy@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 00:47:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx1ar-0005Jz-7u
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 00:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbbKLXrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 18:47:48 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36687 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076AbbKLXrp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 18:47:45 -0500
Received: by ykdr82 with SMTP id r82so120622168ykd.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I4tr9M7Qz04k1LUd5hdMWodRMZaK4jwP5zUQ8aTvJoA=;
        b=fsAkCLWj+ntkWj+NWQxMV1T/H8LmefjbiQcRruFHSCvrrJ0gTPi0bVhdzuvMSWaRHn
         9LLTKXSi1MJxGwH7z4aybkKPU0JjLy+YvnLh3rqkudo0Fj3MhiW2PqFy4s3vLywopQxv
         X0+rDrrj3CyfYd93Ng++YTO0wPzm150RVxm06A2TSnlQchTY2KUOrbTZ9nASxvZcXu3M
         vCrxRtTK/5CiPfhmofyIKCkPfmG93RAncDdujNXrVfLmdZJ6wpyTfBA0Zq4VCM/bNV0q
         svQu4V/S3LtizLSME4zwlmo0YhXG16icutwyn89XRpHy0fW216Nw5x1qR502M+t9mlw5
         U9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I4tr9M7Qz04k1LUd5hdMWodRMZaK4jwP5zUQ8aTvJoA=;
        b=cVUk8mawAubOGCZInNlWcrV7Xq6Ad9uwWRMXDSajSUsnu1GvE659AhbsxUekFoqP5V
         9Fapr2Wx0plS0lg+QaxyVJxW8TRVGs28VNejcZ/S2muhFdofjZk4I2sKi++fNYZMwdmv
         PaGbtj0Jd0suhGTCOj/ViVR0QAqzGxoRNg4BBBObqVyBFtku03GbNb9H/gu71Vfhu+ax
         par6QpmBQbe9L36bDdnNJJGRLJGkSQSreYtJ6sB9vVEE05JLCSlvyNrdtKYCcf9YDuaQ
         zmqvzR/UcgB1F04fiGExT9aEJgtO7mhkWO6RDOj3+y22xibISP7jt/z8j7EkVKSTM0ha
         3uIQ==
X-Gm-Message-State: ALoCoQl/2OO4GYYwgc6p0xyXkWacGHiTN8ie5/3rlyLrd1qxr3IWBzeqUAgqd93V2HFFdvQBYz0W
X-Received: by 10.13.210.4 with SMTP id u4mr18251271ywd.68.1447372064861; Thu,
 12 Nov 2015 15:47:44 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Thu, 12 Nov 2015 15:47:44 -0800 (PST)
In-Reply-To: <19CE7136-E1FD-495A-9BAC-636164757E04@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281222>

+cc Stanislav, who came up with the other thread for passing --remote
to git submodule

On Thu, Nov 12, 2015 at 1:39 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> Notice the other email thread, which suggests to include --remote into the
>> call to  git submodule update depending on a branch config option being
>> present in the .gitmodules file.
>
> Can you check "[PATCH v2] add test to demonstrate that shallow recursive clones fail"? This demonstrates the failure that I see. I also tried the "--remote" flag but this does not work either (see test case).
> Can you confirm this behavior?
>
> Cheers,
> Lars

I can confirm it breaks as expected here.

I may have confused you here by pointing to the --remote option.

(git clone is a bit stupid when it comes to submodule handling.)
All it does currently is this:

    if --recurseSubmodules option or --recursive option is given:
        run: "git submodule update --init --recursive"

No attention is paid to any other option such as --depth.
That's all I wanted to point out there.

Ideally we want to add:

    If there is a branch configured in the .gitmodules file,
    we would want to add the --remote command

    if we have given other options such as --depth or --reference
    we want to pass that along to the called submodule helper.

So I was looking at the internal code structure and think one of the next
series I am going to send will touch the code such that we can incorporate
the conditions as outlined above easier, because it is not hardcoded into an
array ["git", "submodule", "update" "--init", "--recursive"], as I
want to add yet
another dynamic option to the submodule helper invocation. (I want to add
--jobs <n> there)

Cheers,
Stefan
