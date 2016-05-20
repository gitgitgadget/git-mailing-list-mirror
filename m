From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Fri, 20 May 2016 14:39:06 +0200
Message-ID: <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
	<1456950761-19759-1-git-send-email-gitster@pobox.com>
	<1456950761-19759-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 14:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ji6-0004ej-9U
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 14:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbcETMjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 08:39:09 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36509 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbcETMjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 08:39:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id n129so270130813wmn.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6l5xU7OoOzcXa+3QnfPxrd+E6MPmQ1fIbP08enjkBmM=;
        b=vP/8GxIb/GTNIXLPzRaeW68GrEUMpLeXT8RfCffYr3RqgC2VG0Em3R9KEAdvXcPvwY
         djnS+Qstq1cBmdcEQcYz2gWnuWaZTsoYjtK24ZDlyZursN+zA1Nq4VPzYyc0I2VVZ/rd
         bOJa9W7qhI2FGLigAn2MKWIlHeqIC4gRqbaWuVSbgj1KCkFQSRYNJZ1K2ICr33nzE1Ch
         7VMVFRYg8jTeQFDpMSCGrSE53iaPGHXoZJ5kNc9cd9Xsm7CBd4MB192sSDqdKM3VH3NY
         wtC3zZb5KJ8DDGvaWHKyqGIwqNIrD7KL1Tg4Vf/XMQW9TWyo66ugtlzq82nHUXguu0z8
         GMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6l5xU7OoOzcXa+3QnfPxrd+E6MPmQ1fIbP08enjkBmM=;
        b=QpFigoKSoAdTktKJVIAkBdMXVAVLZvgO4IhSKWeCjDoaKq5OdY5DptcHv1yvHyjiAL
         G+zj+GtJfnlp+gmKrRyTPlULKmskvN0qYL2/QoUgFrYuF2AzaWp9L97RNGLROB3vuqRS
         qD40/AhMG2CSZZNe8f2soN2ZBhWk3owRTUZ0kUxdQWxLvoHb72Zzd5v6zsywsIa9N61j
         zwhITMEnDgt2i0RD85Tw/27ZFiC2n8IeqMWqVU0GLRmtVLlM8hvYghB4u6u6VTED0ukh
         pY1vAqd3GaBqc1RMbjniRUBBLAMOZ5Am0tf6JUQkFEGd5DwmjRr8RiX8Jz+Ag83hmlEq
         y9yg==
X-Gm-Message-State: AOPr4FV/TMmXMjkTBiDN9T2IgFgZeG2eXLvduxupHAzi70JFkoGJCSpYcWwlHXJCbDDq7kAo+KOJrf8ny2ODSw==
X-Received: by 10.194.149.37 with SMTP id tx5mr3491707wjb.94.1463747946088;
 Fri, 20 May 2016 05:39:06 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 20 May 2016 05:39:06 -0700 (PDT)
In-Reply-To: <1456950761-19759-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295160>

I am responding to this 2+ month old email because I am investigating
adding an alternate object store at the same level as loose and packed
objects. This alternate object store could be used for large files. I
am working on this for GitLab. (Yeah, I am working, as a freelance,
for both Booking.com and GitLab these days.)

On Wed, Mar 2, 2016 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The bundle v3 format introduces an ability to have the bundle header
> (which describes what references in the bundled history can be
> fetched, and what objects the receiving repository must have in
> order to unbundle it successfully) in one file, and the bundled pack
> stream data in a separate file.
>
> A v3 bundle file begins with a line with "# v3 git bundle", followed
> by zero or more "extended header" lines, and an empty line, finally
> followed by the list of prerequisites and references in the same
> format as v2 bundle.  If it uses the "split bundle" feature, there
> is a "data: $URL" extended header line, and nothing follows the list
> of prerequisites and references.  Also, "sha1: " extended header
> line may exist to help validating that the pack stream data matches
> the bundle header.
>
> A typical expected use of a split bundle is to help initial clone
> that involves a huge data transfer, and would go like this:
>
>  - Any repository people would clone and fetch from would regularly
>    be repacked, and it is expected that there would be a packfile
>    without prerequisites that holds all (or at least most) of the
>    history of it (call it pack-$name.pack).
>
>  - After arranging that packfile to be downloadable over popular
>    transfer methods used for serving static files (such as HTTP or
>    HTTPS) that are easily resumable as $URL/pack-$name.pack, a v3
>    bundle file (call it $name.bndl) can be prepared with an extended
>    header "data: $URL/pack-$name.pack" to point at the download
>    location for the packfile, and be served at "$URL/$name.bndl".
>
>  - An updated Git client, when trying to "git clone" from such a
>    repository, may be redirected to $URL/$name.bndl", which would be
>    a tiny text file (when split bundle feature is used).
>
>  - The client would then inspect the downloaded $name.bndl, learn
>    that the corresponding packfile exists at $URL/pack-$name.pack,
>    and downloads it as pack-$name.pack, until the download succeeds.
>    This can easily be done with "wget --continue" equivalent over an
>    unreliable link.  The checksum recorded on the "sha1: " header
>    line is expected to be used by this downloader (not written yet).

I wonder if this mechanism could also be used or extended to clone and
fetch an alternate object database.

In [1], [2] and [3], and this was also discussed during the
Contributor Summit last month, Peff says that he started working on
alternate object database support a long time ago, and that the hard
part is a protocol extension to tell remotes that you can access some
objects in a different way.

If a Git client would download a "$name.bndl" v3 bundle file that
would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
client would just need to download "$URL/alt-odb-$name.odb" and use
the alternate object database support on this file.

This way it would know all it has to know to access the objects in the
alternate database. The alternate object database may not contain the
real objects, if they are too big for example, but just files that
describe how to get the real objects.

>  - After fully downloading $name.bndl and pack-$name.pack and
>    storing them next to each other, the client would clone from the
>    $name.bndl; this would populate the newly created repository with
>    reasonably recent history.
>
>  - Then the client can issue "git fetch" against the original
>    repository to obtain the most recent part of the history created
>    since the bundle was made.

[1] http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
[2] http://thread.gmane.org/gmane.comp.version-control.git/247171
[3] http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020
