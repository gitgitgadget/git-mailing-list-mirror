From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 12:51:40 -0700
Message-ID: <CAD0k6qS2n-DKcJpz+wjd1ZWLdAsvKMa_hAiu2D_BPKeWhv1jFA@mail.gmail.com>
References: <1398713704-15428-1-git-send-email-dborowitz@google.com> <20140428194449.GM9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:52:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Werb0-0006AN-5t
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbaD1TwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:52:05 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:52930 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932925AbaD1TwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:52:04 -0400
Received: by mail-la0-f44.google.com with SMTP id b8so5496612lan.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HaYKE8IZEhKGmJtjCfgKWU+Ny8GfMd5EsSLpx4cAgd0=;
        b=j7fm7MKH7irAurvu+u3Pit8jBHGYFjQXrUA3Qk3ZNMLQB8M85dVcY48HYWbBpEIVEU
         PsZwY6S1u0QAvbcErXZYhMm/Gc3Pa5Qnj23C+YWM37+p07YCCww2GHHeDUgiX4CdA+hN
         Mxx8quazdWDs31okPf8r4rIcTl2ecc5LE1PQHM66A2cBqpa4uT3p+vkRsSPJ1X4QE7+L
         fqwYltMoOfKz7qpiR3RyBHxEXrM/acAQuob8bLuzWHPpaiRDTwK7tNIcEcwlbrM82uSB
         FlyY0ElmaJSJytVT+yo/GGYdatAMpt87gLenpcwRYyn1yhv+gWcFnwEbmczht2vyJax3
         6hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HaYKE8IZEhKGmJtjCfgKWU+Ny8GfMd5EsSLpx4cAgd0=;
        b=REdldNFL0sL3Z9klzWltozhwWbjFnAS+si1JwF4Pn29WaPFEYei5KRhgtw0ln1/+j5
         XMGk1b/wCPCRIYRhYAqJmFcRMkavgn0gFfkxCcU+vKeXfPX72wrRvT/nZKQNL+q+g+hb
         ieQvRWWnqgofdgr/r6/OALnteHAxe5RdN4Sqc+l2uJJqk9B8yWzay+qqrFDcnQetZ6SA
         vkZ3mBJqYHUBYDTR6fF9cl1rVLo8SW1f1k2v+Or89W0zj28dhjQnDHRhSJoiv+dDI1ul
         Mz8qD7yxbzdxK2G17Ag17X+o+9F1aIgDMXuI34g7T9Vxi0/evTDny68bOy1pL40A3YKj
         nv+w==
X-Gm-Message-State: ALoCoQmv2k01ki9ic76K0HY+v43kxMRnFmPogdgWIqQ73gNhX15uJTz8zUX48AMoOgiKZxyVNfA1yR+qdbUdvb+AVkbGMNZQGbBGysRgqIYNdxLdRqm+Bz6OLVn9CQ66/noAJf3nSrj6SwK/nIGHnw9MQtaz2w3DI+9Gic/PQkfWyI8c8lIfck1888SkRKrqMdtThR2/+hS7
X-Received: by 10.153.5.37 with SMTP id cj5mr2448227lad.48.1398714722014; Mon,
 28 Apr 2014 12:52:02 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 12:51:40 -0700 (PDT)
In-Reply-To: <20140428194449.GM9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247425>

On Mon, Apr 28, 2014 at 12:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Dave Borowitz wrote:
>
>> curl-config is usually installed alongside a curl distribution, and
>> its purpose is to provide flags for building against libcurl, so use
>> it instead of guessing flags and dependent libraries.
>
> The previous version of these two patches is already part of "master".
> Could you make an incremental patch?

Done. Thanks for pointing that out, and sorry for the noise.

> Sorry for the fuss,
> Jonathan
