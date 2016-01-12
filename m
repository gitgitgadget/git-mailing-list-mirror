From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared
 repositories
Date: Tue, 12 Jan 2016 09:05:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601120905000.2964@virtualbox>
References: <cover.1452085713.git.johannes.schindelin@gmx.de> <cover.1452537321.git.johannes.schindelin@gmx.de> <xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com> <xmqq60yzx14w.fsf@gitster.mtv.corp.google.com> <20160111213801.GB21131@sigill.intra.peff.net>
 <xmqq1t9nwznm.fsf@gitster.mtv.corp.google.com> <20160111220603.GD21131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 09:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItxW-0005gj-5c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 09:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761651AbcALIFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 03:05:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:60268 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761540AbcALIFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 03:05:37 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LwJko-1a7F4e1ONK-0186Ce; Tue, 12 Jan 2016 09:05:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160111220603.GD21131@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Y2+UqfQJooxF+2ABYzV5mx/V266hnU94NEd3wVB9qOgjsJO5tZg
 KlNGfw1Cto8d9r2lAhEKpitfWmOlvqduxTrF5ESkaILcyx6Qo2g/T+WDv1DTrR1AnfLNC2N
 eyi57HhTjJvZFHhgJ/KfIahkDPxdpJV3/LqRfu8T/qmVLBHVeS3qrcfDh8a9GPggEnAf8So
 jd3c0/8EXmt8pqLcxtMrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nEagDJrD0FQ=:CmaHhaJMIZ28nIoO+nZyhF
 eiIj/zof52qAdDyeaWXOdM8zOFfrH7VctrcrwkpbYyeK3PrXbx9jf7Aw7Dr1VbEPQHdAUvrcM
 lbJ20VjxzM6xcNWS3OZ4LSlC4s87dKMe/doE5WHZcbKZq+zaIVuP38IpBPxo4e5qB1lR9gBCl
 VVLMNoxDUw9gn96sTMhMEYt//ZjabqK5wo9mUf9R8XK2atAqgmP0KhpFJ1h/RTZNWkNqeEn9b
 lZlEhypv7FxeD1rslXv+W2tlqvqEw0opxWtH8YA+9a1MLwQGxjC2M3VE1hEk9jee/l6hkZcUf
 jKouvXh04Jq2Uvg8QyqfU1DczU1tZRelmnPfNtVO6II1Trls0e3OZRo3lvkygDVf/0gXUGe3b
 +aOo1Rm4CQKQB0IEL861J69H9VUPFrt0XmWVGUTYIN2NcRyBAYaQBI3FYf4EkONSiRbrwY3Zb
 SCbc0RWObOZZPbtlcrFjLAUu11sakp81Tzmd9u/6OnfN/AjMBwPpBz6/UBb1QZrt1mqlKoM1H
 NxGb18hSM+bkBDFhZCM3uYY08POfv3XvpSBuffdewuJe+hlh5IuYUbyFZaSPyAIKvsACiBR16
 Sm9jkI4Dz2sFhED6FtvEIBfcneuOzNAL1Qog2X0/MYStjMXD8+CSLrmsOJMskMOobnsPDWwmL
 icGm83OffLX0WRbecBxJsFDCDZ5eqS4iDIdWas8reM6VckxLITKYwgwegRr0H9UopyfVlat2N
 uFI2Qnvel5ZnL0naC9uloyBccjUfIcjVfF/ZplNbsojXynP6JUfPRbWZ013nRqXgGzMa5gMm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283777>

Hi,

On Mon, 11 Jan 2016, Jeff King wrote:

> On Mon, Jan 11, 2016 at 01:54:05PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > I'm not sure I buy this argument. Yes, you should not be writing
> > > anything else, but that does not change the fact that "fsck" will
> > > unceremoniously abort:
> > > ...
> > > So I think this would be a reasonable candidate (or alternatively, to
> > > treat EPERM on an existing file as a soft error). I am totally fine not
> > > to address it as part of this series, though.
> > 
> > Yeah, that crossed my mind (and I agree with the conclusion).
> > 
> > Listing what is left deliberately and why is still a good idea, as
> > that would force people to think twice before wasting effort to
> > convert blindly without thinking.  Listing what is left behind like
> > "git fsck" that we know we shouldn't leave behind is even better to
> > mark low-hanging fruits.  How do you like this one instead?
> > 
> >      - git fsck, when writing lost&found blobs (this probably should
> >        be changed, but left as a low-hanging fruit for future
> >        contributors).
> 
> I think that's more accurate. :)

Fine by me!

Ciao,
Dscho
