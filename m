From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] convert: add a helper to determine the correct EOL
 for a given path
Date: Fri, 22 Jan 2016 20:04:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601222003360.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c4e6707b53d82cdeeb16c83bddf9c4870a53d9df.1453482052.git.johannes.schindelin@gmx.de> <xmqqegd9v4bl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 20:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMh0w-0003DI-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 20:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbcAVTEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 14:04:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:65359 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVTEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 14:04:50 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LikE1-1ZrC4t3oFx-00cuyJ; Fri, 22 Jan 2016 20:04:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqegd9v4bl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fEXAC7a1PSf4SRXoPci8Nyj+umvJt+vts7Ej+ceZWPxFN55JEwI
 guHY81PGtjhnKdevUgKiX1phcZU+WGahXtttHTTkGE+IWSMl+KsArC6NrhhwZ5ZOnNohrUc
 2/JUknbywjwVBq1sB6tclSkRGsdV493yxFlZskWYgYtGWZbx09xSMaPpZDhfoWl0MAwZMrm
 SSFm4bhg4pmXgBadkDZSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XjtaZpLaYrk=:aP+01giactslO5Zv1HVp8R
 BFEadTHJjTKqGnEIaYtt/ILuTqCKaVPfUX67s2NUoAhXUawi04OfRa03lyPuyLWPwG9lTZ14x
 XfyezC+s5G1/rowDkDYFCii3LITiW0+jG12p1sARsQZ15GB8zmvhQ/EaUzdQtj4Qgoa604W6F
 BGQ0PhzfHVAR+kcsyGNJ5dyKYhSb+IITNN3OOL+6QIRDzyINVYb3xlAvidVg3/tlPOXBGZwkZ
 vUq3KAFfzUht+dZHCB5E6RyVxFRHKmQMaxy/9+A/aJY7r382dKL9mCllSo0WPRxzBFLEoAleN
 vYUrda/eU7ZNqBhEE+ruLizTEAxKSjS4bBrHgRS5ICvomIk6HWmjLrfSgyfI88hPmQB/Mf2xL
 us8PzxTZLMUpzLd/zH5o+SX8NxSmuSWRPqATriFMxQ/O7nj0vsNEW9iFBMGdd1W2ifmu0RMoy
 WwT3u8ZlcZ7Qjj3Mq8jP9OH2gHMMeQelaJlVjOZgPF5T2As065cjX3TI1nSEUvAKXldkfCV5B
 jGEwI6P5WO+7sOFvNOZ2NizGODjOGNMpmCxwuZ7noaXAEDVrA+fy2Aj+N7nmN3P9kfYbrYw6G
 aFYut2Jyn1wczW2RkTzr1pifaB+/Cb5lm27+r02YNLjyPA7PHBy+WbGzMYUgv6uS18ax8ZACp
 u+z7nVE0vXGO0NHcwUu5isssQmMzC2Wjm9TEb+rUcbX4LMMXcq7TrLUqvGHPGC9hiluWBZs/E
 DaPQe6CUX53hnX/t5DlG/XMZ9wtUOmJg+cqWhhqhiu+u1xedXiZMG/DVXVpVyKuyh4q+KzgW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284584>

Hi Junio,

On Fri, 22 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> This change somehow ringed a bell and reminded me of your recent
> ls-files stuff.  Are there things that these topics can use from
> each other?

Quite possibly. I'll have a look tomorrow.

Ciao,
Dscho
