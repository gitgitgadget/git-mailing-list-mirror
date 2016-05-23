From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in
 C
Date: Mon, 23 May 2016 17:10:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605231709170.4449@virtualbox>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com> <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
 <alpine.DEB.2.20.1605161508230.3303@virtualbox> <CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com> <alpine.DEB.2.20.1605231301560.4122@virtualbox> <CAP8UFD1gjfFC_v23RDiHedzwQm3XoYJKv32GT7R9GNyK4pXJpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 17:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4rV1-0000Dr-9G
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 17:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbcEWPK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 11:10:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:64575 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbcEWPK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 11:10:26 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MLO9y-1b4JWj0xjm-000Ywd; Mon, 23 May 2016 17:10:03
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD1gjfFC_v23RDiHedzwQm3XoYJKv32GT7R9GNyK4pXJpQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4+wLmAWSP9gN2UZXGavYKgl+jVA7bPA+s6PvtZIbXhMd/+1xz+A
 G7zjAFh7pzWotNf0N2hvf7mkG4Y2DKSoYKNrjZy4R8v9IWllrkjCYUB9zsrFe2FBNzinzG2
 VlF7ccnFUW1wxPIujHLidJrmKbbSxgHL8JOm2OvoDR4arN/3spqe/x8sHK6RFAT6Av1ndVD
 LRN+hdPHwBZ05SKY0iQlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oqqj6vtbYNc=:OTFM01hmOVXQIHqGAEQJ3H
 HgPWGec4D4revnY4QLqT+86g3Oj0z79uwQYtaK7rK+J6n5Z7gWv4cRt5rY4CM+oM6NSJRbFXG
 KrXPkk21yGZYA1L/bTKL0gdeKi929z5/a8u2wgm/x+tRBinjixLgP1Okvu3ZPpGc7Pqs1yHQj
 vye2lOQpvTGZNnnNFgWtV/fPwUHsmWJ0al62S9Ix+hKjZk9ZmdzEYSbDgSDtfly2RiKFQ/XX2
 P7RGy6dRF95nSLgadpTH3RaTe8La6gQq3PiqaRdQw3gyQNbe0zhEvpdw0lIQddcHwpfWXAiaQ
 dAwlwG7Hd0OFuQ6kyMRcLJiuV0dl2AwZkNyqSSIxBvj2Fuh5v8OHwKwkC5Uz5m6uBF5++sAkq
 iBtZzOnTWHVHPWydubw1Z4j8I85KdqaLKtaizy23VrYcF+nsoRgXoqV7i4ENjWdDGENmuLt6q
 T37oMsoEkkLqBMiQUOjK27jwFIa1iAuSXDH7tylPwZbMu+ZtQFAHunxVMsbDMwKxZGhPrCBuB
 nuU9oIm8FWBT6UMzwvdh1sVUcB9pvf3gXo9nobv7TKImgazYttgTap+7X0irLc7IdFq/moux6
 P5B4e2JUxV93c2Yz2C5CYTcOYx5XblBpNVDXjyuH+8dTLzJ/O3mNuenoNmEsVPMWMyXrMKFaE
 Yrhfx0G8gi/4JTmRCaqC8LjI2iLKTddLWmk9ezPhAJOsNTPxr39CLkdyUuK37cCSazZm40KcT
 j6TyXyNTjtv+05nP0CrC2fK06VjMqE+RMYVLf3d5q6aHYEtorD7X/q9WxYk5A5KlebT4kTA6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295333>

Hi Christian,

On Mon, 23 May 2016, Christian Couder wrote:

> On Mon, May 23, 2016 at 1:07 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 20 May 2016, Pranit Bauva wrote:
> >
> >> Frankly, I have no idea what you mean by libification but I will use
> >> error() since efforts for libification have already started.
> >
> > The term "libification" is frequently used in the Git project: it means to
> > convert code that was formerly used in a standalone program to make it
> > usable as a library function.
> 
> Yeah, and Git standalone programs in C are builtin/*.c files,

Do not forget the non-builtins, e.g. git-upload-pack. And scripts.

Ciao,
Johannes
