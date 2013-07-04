From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: intend-to-edit flag
Date: Thu, 4 Jul 2013 20:10:07 +0200
Message-ID: <CACBZZX5tj0EpV7rv6FymSJunPY-Hs1fJrAmmAOnbEb9WKykmYg@mail.gmail.com>
References: <2240842.MQEMCLPV8Z@x121e>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Thu Jul 04 20:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunzE-0000hw-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 20:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab3GDSK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 14:10:28 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64640 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab3GDSK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 14:10:28 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so2256484oag.26
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eAc2hlxlapp/xl1AMhPlAXintWQ9avgiV7YIk6nECkE=;
        b=OgKMSx3yW4vsJ1tDNg+fUVLiIQWxp1p0X8n/K59Ya+YcBLv+sWOg9HtoXMX712rFCj
         CF9GQcjXXuf4o+Ja4sksRve3iaemO6NXXgE7HUFP8/EOZqFL4rQWXkcBCYrKvZ2bsPg5
         g+06CEStxv6aKgkMIYADwR2kQrHTZR4r+aYJtgQh4kbZBgXLhW463bPPb+ucrie1B5gu
         fnddufDEzAt/2xhdCRbxV0zb0l/qUa1NRStRxOsXjA1lwFgHPqO2u2VW1n7ro8LL2qkm
         ld1udE7Tb0h7jE0gMzbad3NG7RlgWFiHaK9/hhlIKvuk1Km7eURnkw24POmAyKz4aBuF
         oTng==
X-Received: by 10.60.94.210 with SMTP id de18mr7229898oeb.100.1372961427758;
 Thu, 04 Jul 2013 11:10:27 -0700 (PDT)
Received: by 10.76.122.208 with HTTP; Thu, 4 Jul 2013 11:10:07 -0700 (PDT)
In-Reply-To: <2240842.MQEMCLPV8Z@x121e>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229604>

On Thu, Jul 4, 2013 at 7:56 PM, Thomas Koch <thomas@koch.ro> wrote:
> we're evaluating Git to be used in our companies Tool. But a hard requirement
> is the possibility to set an "intend-to-edit" flag on a file (better path).
> Notice that I did not use the word "lock"! :-)
>
> One easy implementation might be a special branch "XYZ-locks" that contains an
> empty blob for every flagged file. So our tool just needs to check, whether a
> blob exists for the path that's intended to edit, tries to push a commit that
> touches the file and only allows editing if the push succeeds.

In my experience everyone who thinks this is a hard requirement is
wrong.

Sure you can implement something to do this, but more likely than not
you think you need it because your current centralized SCM does it and
you think you can't live without it.

I work with a couple of hundred devs all grinding on the same
repository and it's really rare to have:

 * People who edit the same code within each other's pull/push window AND
 * Have the edits to those files not be smoothly resolved by automatic
   merging (i.e. because it was to completely different parts of the
   file).

When it does happen every once in a while it's trivial to solve it,
you just resolve conflicts, talk to the other guy etc.

Why don't you just start using Git and see if this becomes a practical
problem rather than devising some elaborate solution to work around
something that probably won't be an issue anyway?
