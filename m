From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pretty-print: de-tabify indented logs to make things line
 up properly
Date: Wed, 16 Mar 2016 09:52:00 -0700
Message-ID: <CA+55aFx2Yv6=zu_5cXOjeMEKTq1yeqDidRr820HzOSAj3xFb-g@mail.gmail.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEgH-0000I0-3B
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbcCPQwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2016 12:52:16 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38898 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbcCPQwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 12:52:15 -0400
Received: by mail-ig0-f176.google.com with SMTP id ig19so49302958igb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=b2a/OCDq4jEnacdOJ6gDx20K/rrk+h23dgzZB4LaMHw=;
        b=jBoWs4e2o7wyAty7CWZ8tMxvHXo/eoB1b54QZX2LZBqB4RXH4kGMJN/p0po51qAhgc
         yNc8JKqzPL2l8zjp+oJGQbl5adFzZPxf9KhCGW6kqU02hmX7hbq+EJVxY0s5bK3Zclus
         v/xLw3dDWPKX7kB+TPd44OnAguNTzwMTKqlfBoDPJHnCphTVR0PI5iIcqCYXa2FQFjTk
         w9xNJswQIajv9A9dK4t5k6pK/B+6kqJTDA+YpYqHCUCDnOCVxvwGd0XDGzEIaj4S2hdH
         ZwMnxBxUx3CVACGDBxwn0A1h5v15YmuytM8IXI/w0ErpdALTMDt+mX8N+5rIWcLuE9VK
         DApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=b2a/OCDq4jEnacdOJ6gDx20K/rrk+h23dgzZB4LaMHw=;
        b=TgJFM0IsUlGWKu/BirGsRQoRxMd/J2iCyU7Ux2HZC1gqJ3gw16WiJWkdaQ7qIuNQTX
         /heoOjKILPfreiDX9y2tfuHTpAR8WpddjxIpdUKrITWdHUG12JPmPvHIPw6G4O/Iit2z
         j35QyBU6GLzqDy/1/V3Vv9dJ5e7hIYRcaoR7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=b2a/OCDq4jEnacdOJ6gDx20K/rrk+h23dgzZB4LaMHw=;
        b=Mwr7oWSPJD0kqDFqQnz7kWmzy/jz4XtXM8ANjfgQ6Ip4og/NYGQG//AYQT0sgDYE7D
         i90ucbzy/E/j4TVksJf/GXR8c+kPSKbQr5QkwElM4QvqHAU21zLxqVevsbxTbzCcH11B
         2Aa9B2D8pvOaa/zGfi3tB7k/4fdzxURBUKwBnDKNov6ab+OO/nQ0lnhyRa3T32lwdWpc
         RAxYKMsfPvybe1nbMhbHBuTeJ57qxzSF9OURcXrXejcqriAE82mpfKNl6mezSFoaSJMO
         qQ+zHz2FGjhEImU3gzVsUolTn3MTXjX54UxT5Pxz+eX17P70wRCwaiILI9VQcKT6QjxZ
         i4bQ==
X-Gm-Message-State: AD7BkJIGUj814fw1/SqxSm0j1/jLOkueTYTFLD4fJhw09yQnSAnbMh2A4PTwHlKxMxhvc/RMsHO/OePnKriYsw==
X-Received: by 10.50.117.33 with SMTP id kb1mr2051390igb.93.1458147120778;
 Wed, 16 Mar 2016 09:52:00 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Wed, 16 Mar 2016 09:52:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1603160926060.13030@i7>
X-Google-Sender-Auth: 1l0EQGRhEGHoKYqatJdo1tccMHk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288992>

On Wed, Mar 16, 2016 at 9:29 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This should all line up:
>
>   Column 1      Column 2
>   --------      --------
>   A             B
>   ABCD          EFGH
>   SPACES        Instead of Tabs
>
> Even with multi-byte UTF8 characters:
>
>   Column 1      Column 2
>   --------      --------
>   =C3=84             B
>   =C3=A5=C3=A4=C3=B6           100
>   A M=C3=B8=C3=B8se       once bit my sister..

So with current git, it looks like this for me:

      Column 1  Column 2
      --------  --------
      A         B
      ABCD              EFGH
      SPACES        Instead of Tabs

    Even with multi-byte UTF8 characters:

      Column 1  Column 2
      --------  --------
      =C3=84         B
      =C3=A5=C3=A4=C3=B6               100
      A M=C3=B8=C3=B8se   once bit my sister..

and with that patch it looks much better:

      Column 1      Column 2
      --------      --------
      A             B
      ABCD          EFGH
      SPACES        Instead of Tabs

    Even with multi-byte UTF8 characters:

      Column 1      Column 2
      --------      --------
      =C3=84             B
      =C3=A5=C3=A4=C3=B6           100
      A M=C3=B8=C3=B8se       once bit my sister..

(of course, to see that assumes that you have a fixed-sized font in
your mail viewer, and that the spacing didn't get screwed up by my
cut-and-paste).

             Linus
