From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 09:49:02 -0700
Message-ID: <20130608164902.GA3109@elie.Belkin>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 18:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMKN-0001Fb-I9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 18:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3FHQtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 12:49:12 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55811 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab3FHQtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 12:49:11 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so2394059pdj.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xa65tbCkDHxC5TBqHh+VyNyBFBYswkdCrtUKlIzLQCY=;
        b=JAYNN9DgLul2s9lmS/aBU0yooJSvwpBDKCCwgRQd1XK5yF8OyfKbabcae8PUvsBc4I
         J5o1NCYnnUIXYQJ4Fi0IFmoOgzkH2nOWzMrleA2GDEukHyuaQSYMLlaP+RNPbiToJDRF
         o+37/as5GilaUbv8lCVQynYRAHzY1cy9KAokUvyIQOyUAGuTfzt0lIzT97RWmnPTLQ9y
         gUaio3D+b7fHSkgriP2hMY4YZk/2oMIyIr5J6RHetfW8ECjyzfbtj2A805NvGHsrCH9l
         2ob5cQuGCRi6Flq/icAEXeOK3A3olU01KSr8t3Z0TBu/nKsPQwfW6LhpwBGuyvmU85sV
         KrYg==
X-Received: by 10.66.121.169 with SMTP id ll9mr7498988pab.126.1370710150179;
        Sat, 08 Jun 2013 09:49:10 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id at1sm3637797pbc.10.2013.06.08.09.49.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 09:49:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226838>

Duy Nguyen wrote:

> libgit.a is just a way of grouping a bunch of objects together, not a
> real library and not meant to be. If you aim something more organized,
> please show at least a roadmap what to move where.

Exactly.  There are some rough plans I would like to help with in the
direction of a more organized source tree (so "ls" output can be less
intimidating --- see Nico Pitre's mail on this a while ago for more
hints), but randomly moving files one at a time to builtin/ destroys
consistency and just makes things *worse*.  So if you'd like to work
on this, you'll need to start with a description of the endpoint, to
help people work with you to ensure it is something consistent and
usable.

Actually, Felipe, I doubt that would work well.  This project requires
understanding how a variety of people use the git source code, which
requires listening carefully to them and not alienating them so you
can find out what they need.  Someone good at moderating a discussion
could do that on-list, but based on my experience of how threads with
you go, a better strategy might be to cultivate a wiki page somewhere
with a plan and give it some time (a month, maybe) to collect input.

NAK to changing the meaning of builtin/ to "built-in commands, plus
sequencer", which seriously hurts consistency.

Sincerely,
Jonathan
