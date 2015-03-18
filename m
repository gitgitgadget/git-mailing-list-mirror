From: Graham Hay <grahamrhay@gmail.com>
Subject: Re: Seems to be pushing more than necessary
Date: Wed, 18 Mar 2015 12:03:38 +0000
Message-ID: <CAABECY2_A83tWaqb_6YzXwr0Tv5AYVq0KW70j+EHqrx69k2P_A@mail.gmail.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
	<CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
	<CACsJy8Au48iFoC=Eo4T-fm6r6tA7VffRJyH2JbuC==wa61=G5A@mail.gmail.com>
	<CAABECY2_MQWAkOu=6rR=mN=wKz-Yfzsu8o2+wb6F+h4FjBe9Mw@mail.gmail.com>
	<CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 13:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYChR-0002oQ-SA
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbbCRMDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:03:40 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34555 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbbCRMDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:03:39 -0400
Received: by oier21 with SMTP id r21so34092644oie.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3nhCYhPydaddijKqjgk38d/l0mjUbLwA5EylSWyTTzE=;
        b=RTpN8jwK7xSyxgbLTVnTNqfj40iHAhZ8pmGOD4wtDaLejg/P7n/8BlkJ59H2MLr4qU
         qfpohx8R7phdy6wlo2Gl637mzccJ53vPDWIM55QpTJaPpj42Hm2qX5aPYI+OYVPvo4PM
         POvYpB3ZHmfLX2dBzPrH2EpX1MemwkDJ9jrXDMdVvYzfrPYwUfqhCMYhCmPyC0HTtbcL
         /x69S072zp6A/6LHlOgKidlbTRqQKDz1IbJJEQdCY8N//fLWeNIv16Ww01ggbaud6KQX
         AqMrQv3dTb1EcxrBWnZfuHhnXwaqbYogSV6DGLLHzKEsgJZ9SiGg1awfcQL52OxJBOFl
         RFJQ==
X-Received: by 10.182.213.38 with SMTP id np6mr56123234obc.34.1426680218970;
 Wed, 18 Mar 2015 05:03:38 -0700 (PDT)
Received: by 10.76.13.8 with HTTP; Wed, 18 Mar 2015 05:03:38 -0700 (PDT)
In-Reply-To: <CACsJy8DdjDnacVGU83iUDj5Na1xxS6kNDbK2D0Apfv0LAuzDvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265722>

Are there any commands that I can use to show exactly what it is trying to push?

I'll see if I can create a (public) repo that has the same problem.
Thanks for your help.


> This 10804 looks wrong (i.e. sending that many compressed objects).
> Also "80 MiB" sent at that point. If you modify just a couple files,
> something is really wrong because the number of new objects may be
> hundreds at most, not thousands.
>
> v2.2.2 supports "git fast-export --anonymize" [1] to create an
> anonymized "clone" of your repo that you can share, which might help
> us understand the problem.
>
> There's also the environment variable GIT_TRACE_PACKET that can help
> see what's going on at the protocol level, but I think you're on your
> own because without access to this repo, SHA-1s from that trace may
> not make much sense.
>
> [1] https://github.com/git/git/commit/a8722750985a53cc502a66ae3d68a9e42c7fdb98
> --
> Duy
