From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 19:19:34 +0200
Message-ID: <e5bfff550704211019w67cb128ajba0bd1a6b56ada3a@mail.gmail.com>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
	 <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550704210238gfdb5a51i2a7f4a8d16396b28@mail.gmail.com>
	 <200704211654.16393.barra_cuda@katamail.com>
	 <Pine.LNX.4.64.0704211703340.20005@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael <barra_cuda@katamail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJFd-0005mP-J4
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXDURTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXDURTg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:19:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:37153 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbXDURTg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 13:19:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1323716wxd
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 10:19:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGBdhL7Xt36ZEtsrCB23JhRAbTm1V8Cp4CwkVftC8Z0jMwtrKuTW/ZKXfz8XrFLSVBF5MkLOzVaul299aPBK3UyA8qcA68ZK01LrAv5YYaGvcDG3M+oUjhp621esfOhyr5IOtmD5R1Uz/fG3RmbvdODUPzeJR7ZG3h+G2lcrOBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JCjaUT5Ab7RDWv8UHksb0O9nCU6CaIUT05N9YlefI0VbpWJ7Ot3fAXY11L0HScvUkJRSPzNDFS3035hni4CJO0M9GewolNw/fegw5qdEWEJJ0PyKhyIywFgnuuJdoGsi8t/FCNexinB3vmfJ7h+5+BKMgIspV4qzcCncHgMYvhA=
Received: by 10.114.25.3 with SMTP id 3mr1750472way.1177175974572;
        Sat, 21 Apr 2007 10:19:34 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 10:19:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704211703340.20005@beast.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45183>

On 4/21/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Sat, 21 Apr 2007, Michael wrote:
>
> > Marco Costalba wrote:
> >> On 4/21/07, Junio C Hamano <junkio@cox.net> wrote:
> >>> "Marco Costalba" <mcostalba@gmail.com> writes:
> >>>
> >>> $ git rev-list -- git-gui.sh | wc -l
> >>> 158
> >>>
> >>
> >> This is strange....
>
> try git rev-list --all --full-history -- git-gui.sh | wc -l, that gives
> 158 for me (in the git repo) ...
>

Yes, --full-history here is the missed link here, it works also with
just HEAD instead of --all

$ git rev-list HEAD --full-history -- git-gui.sh | wc -l
158


Unfortunatly this is much slower,

$ time git rev-list HEAD --full-history -- git-gui.sh > /dev/null
1.77user 0.03system 0:01.88elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+4030minor)pagefaults 0swaps

$ time git rev-list HEAD -- git-gui.sh > /dev/null
0.80user 0.02system 0:00.91elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3382minor)pagefaults 0swaps

   Marco
