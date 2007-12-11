From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 11:21:57 -0500
Message-ID: <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27sB-0008AB-MB
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbXLKQV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXLKQV6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:21:58 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:17269 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbXLKQV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:21:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4086363wah
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FV7ahHgVLFQ7ZNcVTKi+DUlQJJtm03Yn+9RVlwkOqx8=;
        b=OQmX82fLGOuxbdMnRI8JlXhj8WEdlUXUgHllnoTGSLRITj0IOrcy+HlXCWuKSetORmoRVmlykAQX85Ig72CC0OpwfzKP1v2/fKkQ3cR82erXepxGSpEW6QLF/zxl7d9FCy7S3EYIm3xq0e76MPGjAjaSPCN8uIQACwBDpiymu14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lKwEZGC4pE5HWDC7cWHK+X5iVRyOWIeQdFsWXH+hDtIy4zuNXANNXZ5oGGqzAc/tVeFNpmKgUtB65M7yunnmIeWOrtK0JS3hnWc+xvpkAdDZhUpKa63BtlOPWm0KGSrFNyyqm+6+ZW4Y03ZskrwuDAypBpvBw9H7sJ3td0jyaqY=
Received: by 10.141.87.13 with SMTP id p13mr174237rvl.1197390117625;
        Tue, 11 Dec 2007 08:21:57 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Tue, 11 Dec 2007 08:21:57 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712111117440.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67881>

On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 11 Dec 2007, Nicolas Pitre wrote:
>
> > OK, here's something else for you to try:
> >
> >       core.deltabasecachelimit=0
> >       pack.threads=2
> >       pack.deltacachesize=1
> >
> > With that I'm able to repack the small gcc pack on my machine with 1GB
> > of ram using:
> >
> >       git repack -a -f -d --window=250 --depth=250
> >
> > and top reports a ~700m virt and ~500m res without hitting swap at all.
> > It is only at 25% so far, but I was unable to get that far before.
>
> Well, around 55% memory usage skyrocketed to 1.6GB and the system went
> deep into swap.  So I restarted it with no threads.
>
> Nicolas (even more puzzled)

On the plus side you are seeing what I see, so it proves I am not imagining it.


-- 
Jon Smirl
jonsmirl@gmail.com
