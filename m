From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in
 C
Date: Mon, 23 May 2016 13:07:38 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605231301560.4122@virtualbox>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com> <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com> <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
 <alpine.DEB.2.20.1605161508230.3303@virtualbox> <CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 13:08:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4nic-0002SW-AB
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 13:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbcEWLII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 07:08:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:53797 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbcEWLIG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 07:08:06 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MHH3P-1bHi9p0iEV-00E3kE; Mon, 23 May 2016 13:07:54
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:X1ZWce2tS5LlDfcELEY0ivqY/SK8OYFScrwsXtNpzHyTk6/Ohyw
 yDd7WTaGq/w/MyGuR0i2ZRQM6sr9DswRTLsicQrvOkie1f+bAi8I7zbmOTmE4S8EU1D6yRb
 u0NQ+ZT1HaSfv5ZBtXTm1lS8bUlMQrcJCqwYxwkyjKDeqUAdmHYlE6jFjFusvD+2yvmngtc
 2FtnJNuym3ISAIXccJN8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CDsJrk/Wc3g=:ILGz/FEdu3Ji3b/Dab/a7z
 k9TkTns6lSvYIJGETs3F0tg1mnDwzpE5vWyYSSc1iyC7Zh0gg5+Nvb3niRgL+OumVvfSiPmq8
 E07Nq8WWkL+QjMHXISs1xNP/jrtrB8BPsoWBJdWaAEtfLqQbBKk+bRY+A/qukLbsgvwDazgrl
 8kNWXz/LOem5vMWWBKIOZPi9Q1efVgw1BUR0a08W8FxxPqmvJknuuHwaSg92k5b+5ulrGZYjR
 vOCdZhA1bZmym2kzUnBhMP0msj2Z/hxoShM6kc58tGTrp28xIv8O5SzieCY6pq7EI/WxO4U42
 bCIS01F14h1stjNWH+sNm5MATj58Y+KzNMhIapWfXr0uGSDlkOmjB+2BdEM7dzvpI24MW7rUl
 ZmjGBX9thIvIjm1YuKp48rbGijh0mzXYS+krj2qI+xxbSzlsHFpwwh7ukUacjlkfAPdO8CMCN
 pzV185z+04k2afOri79GI/B0Us4d8bWSo5O20lKROiH2/tgvE0ihYyCiZ0yGH+HPqXB9kE4KY
 c01HH78wpR5o8ukO/dlXyjyyhIZ4BauAh6Ofse+X0EeBNAgwnHhUG5TfD63rHdxJRQGwlVuYR
 Vm2Ie0KMLMRfafGbMtIZI91KFasnTJIr7M4hM1jsgMe0FnsUw1Oh9RQ1fyLEfTLcowHhIOGeP
 eTc+L4/YunABBl3eHpn3V2frBMCCWWBs2SNVa+U53m10+flGKjnNGWdWXuhwhaegkDy3osJQV
 yXmwBgSpKH8qEjgkBHxAUzBEm+wWaYYvnh6fSwVqBnMjzRiTqrT1UfOyvcZmq+Ezva+z8lZr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295316>

Hi Pranit,

On Fri, 20 May 2016, Pranit Bauva wrote:

> Frankly, I have no idea what you mean by libification but I will use
> error() since efforts for libification have already started.

The term "libification" is frequently used in the Git project: it means to
convert code that was formerly used in a standalone program to make it
usable as a library function.

The main differences:

- in the standalone program, you can get away with calling die() when
  anything goes wrong. Not so in a library function: you need to give the
  caller a chance to fail gracefully, or even to continue.

- in a standalone program, you can be sloppy and "let exit() clean up",
  i.e. omit free() calls or even close() calls. In library functions, this
  is not possible.

- in a standalone program, you may mess with the stdio handles. This is
  an absolute no-go in library functions.

There are other differences, of course. The gist is that you have to be a
lot more careful for library functions.

Ciao,
Johannes
