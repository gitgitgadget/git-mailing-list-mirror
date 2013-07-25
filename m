From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 14:30:27 -0500
Message-ID: <CAMP44s1H1G-G0SvvegLsTfFizprzRkw8TfqcJi8hCr-6+8WnKQ@mail.gmail.com>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de>
	<CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
	<F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
	<CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 21:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2RFB-0005fn-T2
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 21:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706Ab3GYTaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 15:30:30 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:37543 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab3GYTa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 15:30:29 -0400
Received: by mail-la0-f51.google.com with SMTP id fp13so1585856lab.24
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uuY9Pll8ZkgxMulnP2X0nsnpn+1mRnhd+sH3sbnGMac=;
        b=uXs1p+RscHF93deuQpTIwTsvdW92wcy1sG03oUmZLVKLpy6lYRPny7HfT+yZPjvqdq
         wXutkS4hQsenU+OGlHZFM+2tjLsrltq+q3HWKaSZrcMGv0FRp8r7ZfIq7xRXmlduJ29o
         N7boOtgRfz2Vhdyd1FJJne4/NrH3TcLKBJ6zmZ8gkVFdgndzhz64HTiw321yZIW0auX+
         qFCyMjg1St/ieU2crWPNTcVoXSN5pQZHr4NrNIvMTAZp5nakqIveMEBg7OAD2hduaI2S
         fQgVQWjkdO2I9UJ8LMpqdHKTodJqbSFoRBvNVM9X/XiVWPCRlC5GWvQ4WhjUPEU4hHR0
         j3XQ==
X-Received: by 10.152.28.162 with SMTP id c2mr19633096lah.45.1374780627590;
 Thu, 25 Jul 2013 12:30:27 -0700 (PDT)
Received: by 10.114.175.227 with HTTP; Thu, 25 Jul 2013 12:30:27 -0700 (PDT)
In-Reply-To: <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231145>

On Wed, Jul 24, 2013 at 8:14 AM, Antoine Pelisse <apelisse@gmail.com> wrote:

> IOW, the goal is to have only one copy of each "hg object" that are
> shared amongst many "remotes" (and potentially import them only once,
> though I don't think it currently works for me).

That's right. I had code to import only once, but it didn't work
correctly; we would need a way to have shared fast-import/export
marks, and I don't think it's even possible from Mercurial's API to
figure out which objects are shared and which specific, so I gave up
on that. Sharing the repository is the only thing we can do safely and
sanely.

-- 
Felipe Contreras
