From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 18 Jun 2014 10:33:48 +0300
Message-ID: <20140618073348.GA22670@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
 <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 09:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxAN7-0000Wf-W4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 09:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbaFRHdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 03:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbaFRHdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 03:33:25 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5I7XLvU026506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2014 03:33:21 -0400
Received: from redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5I7XJWU021467;
	Wed, 18 Jun 2014 03:33:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251970>

On Tue, Jun 17, 2014 at 11:49:11PM -0700, Junio C Hamano wrote:
> On Tue, Jun 17, 2014 at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > OK, after looking into this for a while, I realize
> > this is a special property of the Signed-off-by footer.
> > For now I think it's reasonable to just avoid de-duplicating
> > other footers if any. Agree?
> 
> Not really. I'd rather see "git am" hardcode as little such policy as possible.
> We do need to support S-o-b footer and the policy we defined for it long time
> ago, if only for backward compatiblity, but for any other footers,
> policy decision
> such as "dedup by default" isn't something "am" should know about.

OK happily that's exactly what v2 that I just posted does.
Default S-o-b footer gets the existing policy.
Any other footers are added on top without any tricky
deduplication.


-- 
MST
