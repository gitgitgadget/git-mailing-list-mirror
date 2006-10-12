From: apodtele <apodtele@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 19:12:24 -0400
Message-ID: <d620685f0610121612y62f335e5pc5930354edb8cd67@mail.gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	 <20061012201646.GC10922@admingilde.org>
	 <d620685f0610121437m38eb454g7597b2a93010b023@mail.gmail.com>
	 <452EBF99.5020108@gmail.com> <20061012222703.GA31152@admingilde.org>
	 <452EC625.7050301@gmail.com>
	 <Pine.LNX.4.63.0610130051440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 01:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY9j6-0002vV-11
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 01:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWJLXMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWJLXMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 19:12:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:33235 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751292AbWJLXMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 19:12:25 -0400
Received: by wx-out-0506.google.com with SMTP id s14so695762wxc
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 16:12:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QUjgKh4Ft6CeTW2Urw8Ixb2lUumuZqPgbj3BW2Mz6i2kZc365RxKfqXBgfnBwNMABM88bIt6YURchI8yrl3Ah7H8DaqgJk6O7BFUNEdj50lo/HTEzGRxYYoE8Bxnkfq/5AzDaYViKkInKAqD9PCPK8/gG8TNQAbkbI3veuiFGow=
Received: by 10.90.27.6 with SMTP id a6mr1830092aga;
        Thu, 12 Oct 2006 16:12:24 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Thu, 12 Oct 2006 16:12:24 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610130051440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28818>

On 10/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Am I the only one finding non-linear diffstat ugly and misleading?

Well, the scaling I propose _is_  linear for small changes. More
importantly, the existing scheme is not linear across the diffs
either. Different stats may _look_ the same but be very different in
size in the existing scheme already. My proposal is invariant across
diff stats. Junio's argument that a change of 30 doesn't look like a
half of 60 is valid, of course. Does anyone really checks this with a
ruler?
