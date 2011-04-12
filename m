From: Dave Abrahams <dave@boostpro.com>
Subject: Re: git-svn dying unceremoniously
Date: Tue, 12 Apr 2011 12:02:05 -0400
Message-ID: <BANLkTikeCagEiN_xU4B+TE=-9esQjWh0pw@mail.gmail.com>
References: <m2fwpov47e.wl%dave@boostpro.com> <20110412021202.GA17114@elie> <201104120850.47331.andres@anarazel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Andres Freund <andres@anarazel.de>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:02:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9g3L-0006FF-GQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 18:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab1DLQCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 12:02:50 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60950 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab1DLQCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 12:02:49 -0400
Received: by vxi39 with SMTP id 39so4995736vxi.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 09:02:46 -0700 (PDT)
Received: by 10.52.172.242 with SMTP id bf18mr5934423vdc.161.1302624145264;
 Tue, 12 Apr 2011 09:02:25 -0700 (PDT)
Received: by 10.52.163.8 with HTTP; Tue, 12 Apr 2011 09:02:05 -0700 (PDT)
X-Originating-IP: [207.172.223.249]
In-Reply-To: <201104120850.47331.andres@anarazel.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171402>

On Tue, Apr 12, 2011 at 2:50 AM, Andres Freund <andres@anarazel.de> wrote:
> Hi,
>
> On Tuesday 12 April 2011 04:12:24 Jonathan Nieder wrote:
>> See
>> http://thread.gmane.org/gmane.comp.version-control.git/134936/focus=134940
>> and the surrounding thread for hints.
> I hit that again some days ago and after stracing I started dumping the
> network transfer. For me it looks like the server simply closes the
> connection. Seemingly always directly after a tls key renegotiation... I
> didn't dig further so far.

I managed to get a lot farther with

   while ! git svn fetch ; do sleep 1 ; done

But eventually I exceeded my disk quota:

error: bad index file sha1 signature
fatal: index file corrupt
write-tree: command returned error: 128

:(

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
