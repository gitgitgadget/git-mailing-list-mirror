From: Guilherme <guibufolo@gmail.com>
Subject: Re: Fwd: git clone does not respect command line options
Date: Sun, 28 Feb 2016 09:07:23 +0530
Message-ID: <CAMDzUtyjf2LwYJTYcY588LgrSNfusX=L09oFeS4UhLjH+WpEOQ@mail.gmail.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
 <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
 <20160226073444.GA26340@sigill.intra.peff.net> <xmqqegbzl86d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 04:38:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZsBO-0008I2-Rr
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 04:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992715AbcB1DiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 22:38:05 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36530 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbcB1DiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 22:38:04 -0500
Received: by mail-vk0-f42.google.com with SMTP id c3so107606610vkb.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 19:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=972vkrExRUINlrn9UTHrxbAC4Lv+cGvB4LLV/YcpzQQ=;
        b=0G+rDslLYfaXnARbK5gMFODmbrL0Ero0bWDXhGW/iqMK3GeXG/o921x0PUSGXBrGVR
         S1S0bG8K/gk4hbftnZlD9+3s82W7UO3xfsPcQ+LQoT/FI01IXDzhd8s2V9TNnxvxuaTw
         okH40RjiHHbnDgw0Z0Q7XOtO1XSu2bwh03xaxU7lUMQ/PRVS81FYnkGj+BseGRDU3xcg
         nm5KPlQRWSjOWBjCGkFu+8apU1c4rQmVys+tD6B8zvFPjumEj1pUvVMKEqQN+2FekwG0
         RG3mCR3EwMBU4O0eLtlmlWKzwtuZ/7bIT7GRa3LsdAsjWkTL6ydLkpKZ+WKCtHzA/chh
         tw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=972vkrExRUINlrn9UTHrxbAC4Lv+cGvB4LLV/YcpzQQ=;
        b=dXdyBzxTqFz2s3OniKnk7DAvHnn/hG17uwwS6mzYnTX6yVlk/fiIRwyzYCMAJeEVgs
         X57+aFpSSV8QQ67Hcnv1YvWdz+jjFgZ43CsRbVVlcEDOPKEccisqA8zCGk5n6rMgfYXx
         mdv9v3dQkUn1AEpkm4oTJNbOZhYQxdkhXUnCdW4wMfKMD4SofXU4mrBFq7GKq7wyNW7C
         kdScASFesw3+AFehvLkCBB9tzZ0clCSKguA7PVeVMriazC4jKqC3DtRQ+VVtpg+d46TI
         JP19XeIj7YERj7YHsfvwBGIBLRt4c+nEFqZk0KlZ3A7hYA3IQzvRM/qNupE0M5h+nu/f
         05SA==
X-Gm-Message-State: AD7BkJIcFk1zMlA5IRh9RZRP+ZBctFsh688NqcyXGCkVLGOOn15k/b2X7vFf1Nxik4uQxMyp7WA4nTD1o2iYOw==
X-Received: by 10.31.54.207 with SMTP id d198mr6886646vka.119.1456630683302;
 Sat, 27 Feb 2016 19:38:03 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Sat, 27 Feb 2016 19:37:23 -0800 (PST)
In-Reply-To: <xmqqegbzl86d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287738>

What is the current situation if credential.helper is set twice in the
same config file.

Either
[credential]
  helper = first
  helper = second

or with
[credential]
  helper = first

[credenital]
  helper = second

Will both be used by git clone?

How do i remove these from the command line?
I tried git config --unset credential.helper but that only gives you a
warning and does not remove any.

Worse is that if second is the empty string there is no way for one to
know there is a second set unless he tries to delete the first one.
But one still cannot query the value of the second.
