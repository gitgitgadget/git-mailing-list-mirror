From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Mon, 23 May 2016 13:09:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605231308070.4122@virtualbox>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com> <1463169737-12701-2-git-send-email-pranit.bauva@gmail.com> <alpine.DEB.2.20.1605160838540.3303@virtualbox> <CAFZEwPMFBmHUaX+Y8Fpd4BnJiB8N_XBOX30hRsSvb3tm8-MX5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 13:09:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4njb-0002tF-BM
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 13:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbcEWLJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 07:09:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:58841 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbcEWLJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 07:09:14 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MXIov-1b1geX402P-00WIrw; Mon, 23 May 2016 13:09:09
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPMFBmHUaX+Y8Fpd4BnJiB8N_XBOX30hRsSvb3tm8-MX5w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:J4tE7uu2SMdZoA2xpYciRNlPAan2LXokrEOuxoun9azgJdnZufe
 xlWtR0KfsdjWNvk/LyLNfBzLUbLaNvQuwGvWEIf6qJ8O1K2FT9+J43+t1yLRQ0Thw42Aeqe
 hjqRmCj2nEgK1K7vaLMK0kW6fgRNMsfX18vsmiCyHJXzcydzorE0anc0FzquSDqxRLVtgG0
 PxUBXRLpkxxARylYDOaog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K68T6baA/Jo=:V3qAo0UsCqVFyUVYuMZJTA
 E9+mkCuBDZlSo9JlQhgt6xXxmLQVWFpYhZHNOds+SdyEYWqZt/NnO67EHF/xRWix+E7IHuW0h
 flYHcHkCHs17vgT3TJnAwnkwG9ETAi6UcKgOOKqL467tb9ncOH5VtzgAb2bY9g6fuxUQ2VKrl
 FVpW1CFDwuLHyB7zRUmjWgnMYyVFoO+rnE1al+5fdlOQbf3/SNoe6I4NNcI2P6Q/pmJBOh/1/
 zR0mp1l3qs0mubDVR7Hsb4B9fgAsaJNh3uaM6ZaKbCDwYiF5/565gfiFY0dxs2X0142L9ZcgW
 Ky1QJMj1d6giYtqWesy1l4KjKc5mi2zHW9CBJZXHv8y8Qh9oPykdQdicgJH+xn1kEblTs6z66
 0oX0R7i0xVAqeYiEslzraxuGVkUAujDas2BL5I5y8jETxn80va6v/kF59W0z7qUS9PPZot4jo
 lLGPeaib3kMOf/xs2Rw/wA+0N6bliBC1T0iu27r9gE5d1gs5jjQoBmW6aA7JFgmcWaQo7xkDr
 AqVlpUrNQbDDqxXmVEc6HzOnf2l+m6WJrtpj+pOi/3+IJz7s6zvwnQP7PblcLWIH3bs+RfZGp
 mw/RPTdZ14AMgDh9LdVyvZ/pccZW8GGXJCY0Voal3RD8yY4epFsmMBS560b08W/gsCD1B63BI
 voJzwU+8zkkEffys7brXllH/Eh0zRHtWCOPXyEKyawNAVi58W5d4EG2eJZp6pUKG3HbIKu2H6
 TKl383YHDscReYbP/r1g+P6/IFR6rvANsTrL8pqbhu8Nd1OHcR2PnEoujmajthsfXKyuT8M+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295317>

Hi Pranit,

On Fri, 20 May 2016, Pranit Bauva wrote:

> On Mon, May 16, 2016 at 12:10 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 14 May 2016, Pranit Bauva wrote:
> >
> >> Reimplement the `bisect_voc` shell function in C. This is a too small
> >> function to be called as a subcommand though the working of this
> >> function has been tested by calling it as a subcommand.
> >
> > This leaves me puzzled as to what this patch is supposed to do. Maybe
> > rename this function to have a more intuitive name, and then throw in a
> > patch that makes use of the function?
> 
> Are you suggesting to first have an introductory patch which will
> rename the function in the shell script and then this patch which will
> convert the "new" shell function to C? I can do this. I have to think
> of a nice name. How does 'good_or_bad" sound?

For such a short function, I would simply use a more sensible name in the
C version of the function. In other words, I would not bother with an
extra patch but do it all in the same patch, describing it well in the
commit message.

Ciao,
Johannes
