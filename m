From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Fix git p4 sync errors
Date: Fri, 26 Oct 2012 17:44:13 +0200
Message-ID: <CAP8UFD0+FPDERfkTeJWuq=T6RQ65yjHwbhTP_SYv6aA+1xq32Q@mail.gmail.com>
References: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com>
	<7vwqyjfxwd.fsf@alter.siamese.dyndns.org>
	<F0F92B0A-D37F-40D4-A0DF-43EEDA2818B9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: Matt Arsenault <arsenm2@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:44:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRm5I-0001ow-00
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896Ab2JZPoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 11:44:18 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62591 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933879Ab2JZPoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:44:15 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so536616wib.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=itDCwRRWeEoJ84BX2bNyoF4rgkYbwmkUaKej6K8f6rA=;
        b=gSi7PO1b/WbQjXJ9erIaFCHeEi7HxroVyN5NsukpJbHbo1pWFyY52iXtdoIx4IG4TC
         9UeHawwcgjrLBSiSRRM+tBfxQ4JHf4NvyoL/ETaO2+1AiGElsONZoT0p7VtJF+Y50WEF
         F/pmzGl9ueETg44oQBCRztSHE7B+i58S67DURp4nnJ2V0kBAgH0RumolKsYxYwxee5PR
         dXvAF6d/LER8i22SvBi7cTBdC+Kb7OAz0kulyWZ6k0C5jeSxd9kAQXaDBTmRz6XmYUmH
         nLFzT8PCCosZdHy0hvZfi8lEtVUEKKWT2txFrsXbrWKCczmPmiZuwhSrtFFtZnB2eIej
         wX1Q==
Received: by 10.216.217.195 with SMTP id i45mr13729327wep.14.1351266253618;
 Fri, 26 Oct 2012 08:44:13 -0700 (PDT)
Received: by 10.194.138.42 with HTTP; Fri, 26 Oct 2012 08:44:13 -0700 (PDT)
In-Reply-To: <F0F92B0A-D37F-40D4-A0DF-43EEDA2818B9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208455>

Hi,

On Thu, Oct 25, 2012 at 4:41 AM, Matt Arsenault <arsenm2@gmail.com> wrote:
>
> On Oct 21, 2012, at 12:06 , Junio C Hamano <gitster@pobox.com> wrote:
>>
>> - Why is it a bug not to pass "-s"?  How does the bug happen?
>
> I encountered this one time after using it for months. One day I couldn't git p4 rebase
> with the key error.  I searched for the error and found some version of git-p4 that fixed
> a similar error by adding the -s to describe. Adding the -s fixed the error and
> everything seemed to be working correctly.

The perforce documentation says the following about this flag:

"The -s flag omits the diffs of files that were updated."

So if the diffs are not used, there is no downside to use -s.
Maybe the patch should just state this.

Best,
Christian.
