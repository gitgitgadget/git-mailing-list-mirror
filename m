From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 19:32:12 +0100
Message-ID: <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29uJ-0006Ve-8P
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbXLKScR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXLKScR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:32:17 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:30261 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbXLKScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:32:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2127707rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XCoJSGSCYqdxWRI51PHxa/3TnyTtUm5juZvNEh7nQfw=;
        b=l35k2Q3F7AaTz4B/dZYHwbV8jNCaCeKlPDk3xciTZgvZOdP8jUvCf/FTes9AcEcOchp9lYCbmHGtjDAZHaSmxwpdkwanXTAxpTiHGa+xa8ZPQyLpI2osobszKYEqGgQvcee6ohaF2Eja2PP4hgk/mQ8cMsfSypwoxq9Eq3YoK3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5K+NNezBE6pajXIOGgj22fzxFPjZobIEZiVHUtmULvyLZYU/33a0+PZcHBHFmDzOEFf0UT/1HZu2xiMGB4WUVC1ATB69Bw5rChC8pPIrfWH2u0GKj7bUqK6XV5ZahLOV5Ixpky9qHHLWJngBMZBqJ/Bd+KSsQBksZyMSdTGSvs=
Received: by 10.141.90.17 with SMTP id s17mr5202024rvl.1197397932433;
        Tue, 11 Dec 2007 10:32:12 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 10:32:12 -0800 (PST)
In-Reply-To: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67900>

On Dec 11, 2007 6:33 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
>
> Annotate is treasured by gcc developers (this was a key sticking point
> in svn conversion).
> Having an annotate that is 2x slower and takes 15x memory would not
> fly (regardless of how good the results are).
>

Speed of annotation is mainly due to getting the file history more
then calculating the actual annotation.

I don't know *how* file history is stored in the others scm, perhaps
is easier to retrieve, i.e. without a full walk across the
revisions...

In case you have qgit (especially the 2.0 version that is much faster
in this feature) I would be very interested to have annotation times
on this file. Indeed annotation times are shown splitted between file
history retrieval, based on something along the lines of "git log -p
-- <path>", and actual annotation calculation (fully internal at
qgit).

I would be interested in cold start and warm cache start (close the
annotation tab and start annotation again).


Thanks (a lot)
Marco
