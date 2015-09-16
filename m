From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Big path on git add file [windows bug]
Date: Wed, 16 Sep 2015 11:40:22 +0200
Organization: gmx
Message-ID: <01b34f993289e7dcef5c6fef3d855372@dscho.org>
References: <CAMg53oum4s2HE5A-H4g-3N8akOm4KetHM6ntUqRPnygLRALwpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexey Kasyanchuk <degitx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9CX-0004zw-E1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 11:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbIPJkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 05:40:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:52978 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbbIPJkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 05:40:24 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LnwxU-1YwSjO24hk-00g2YV; Wed, 16 Sep 2015 11:40:22
 +0200
In-Reply-To: <CAMg53oum4s2HE5A-H4g-3N8akOm4KetHM6ntUqRPnygLRALwpw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:QVVLvRt3PTHJptyxRHui67ajY/j6S9/N6/8oH4efMQKVAPgtG5M
 lVNnCYS4Sqac+9AlmdkTSBP0qK5r/rzXPK/Oh3yP79ywDFVcAC8Cv0O3rNOHMSgK/Eajemv
 E052roXcL5zf3FJejo3LQc1VQjzj3Sbzcu6izSOIdbl7/QjC0XCkR6iORlSOkXlnOaojtVw
 ARKDSVkQ5DVi7L33DpdNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:baVWSI0sAvs=:SnT1qoghKZRA/EnaYVaKpm
 n2232t/famD5cR9D88ab2oUAC7FIWjmiQsa0n6XvRQtUnoBS6u/Q4ctvv5Pb1xxnFPWB6bGts
 BVhvYyHZ+SakBlrrI4DknijogufsGrWy/uNLCrJSVn3Ysg1dgIZwSbE0P5hXIcAa6vc+bOKrL
 +ruTieH0fn9o9JG1GLvUqjKKD9CKAZLe5l9IYlytQvQcBTJMoyfDG9UP9qi3EFyav+Zju7T2O
 ugsrfUUeXzjdHmnx53Qu2RgL0pyzUikQPEi9NoA4lJnF7javD/Tb3XI+VydsCocymHRsMG/1F
 l9N2UTGG8I0gIutq+cXLr2Bt1zddaIgwdCNPXm4IKE5+IOEHzuZURvfTc0qCd8foubHjfelD1
 2jOepGavhkk7IfoejmKEmSp9tCytaZKp/0Fx8m+4AEcyZ5/+BEo+pNzZzMVC6B7AaCQnpO9cL
 gGI/JX3idj6zQwmsfpkJyVR91ABE13VQBPBDOeUyxhx5TlFCyW/0zLkI9Iz7SIRJ7ufumakd8
 OPzOJUF/OW0U+yASBpEbi6uUWf97OMuVl7gXYUG79XslKeXgvLFHaB8vRmJ5uMD6QNuddbCuN
 frBg1VZeL37lIgqmpBdpvZ0xY/NMu9giOaqyVZnZx36tdAeWUxKwerMZr/GCjiZoSXV4lP3V7
 +A3+BJzRBcmaC+UWU6WHTFRgv/sqH3c1ePlsRkBaiSZOJb5mm3yIBKZnSpA5hRq7GLEoWj5x9
 rFLDMRyogddYYifZD3SI8fwRo7mOEOYDDEtEKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278010>

Hi Alexey,

On 2015-09-16 10:01, Alexey Kasyanchuk wrote:
> I tried add one of node.js module to git project. But add operation failed:
> 
> libgit2 returned: Invalid path for filesystem
> 'E:/Projects/vsteams/node_modules/gulp-imagemin/node_modules/imagemin/node_modules/imagemin-gifsicle/node_modules/gifsicle/node_modules/bin-build/node_modules/decompress/node_modules/decompress-tar/node_modules/strip-dirs/node_modules/is-natural-number/is-natural-number-cjs.js':
> Data area passed to a system call is too small.

It is indeed too small for normal operations (MAX_PATH is somewhere around 248). However, as far as I know, libgit2 has internal code to convert the path into a form that the Win32 API can handle.

> Is this windows problem or problem with libgit2 realization on windows
> (windows 7 by the way)? It looked like problem with big system path
> (276 symbols). May be some sulution for this?

Yes, there is a sulution for this. But it is unclear whether you have that already or not because you were a little parsimonious with information. For example, I have no idea which libgit2 version you use, in which context, what program you use to call libgit2, etc.

So I am left guessing, which is a little bit inefficient.

In any case, the work-around for the issue you described is in https://github.com/libgit2/libgit2/commit/cceae9a25d0bed8b00f4981e051d5f380ef54401 which is part of v0.22.1.

> Version: Git-2.5.2.2-64-bit

No, that is not the correct version. This looks like the current Git for Windows version, but the error you reported is clearly a libgit2 error message. And that Git for Windows version contains no libgit2 at all.

Please clarify. You might want to err on the side of verbosity to avoid unnecessary back-and-forth.

Ciao,
Johannes
