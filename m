From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 18 Jun 2014 06:09:03 +0300
Message-ID: <20140618030903.GA19593@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
 <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 05:09:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx6Ft-000894-ME
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 05:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbaFRDJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 23:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaFRDJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 23:09:41 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5I38ai1025191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2014 23:08:37 -0400
Received: from redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5I38Yx3016816;
	Tue, 17 Jun 2014 23:08:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251965>

On Mon, Jun 16, 2014 at 11:06:20AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Now A wants to sign this patch.
> >
> > I think there are two reasonable ways to behave:
> > 1. What you describe above:
> > A
> > B
> > A
> 
> That is the only sensible thing to do for Signed-off-by footers.

OK, after looking into this for a while, I realize
this is a special property of the Signed-off-by footer.
For now I think it's reasonable to just avoid de-duplicating
other footers if any. Agree?

To have it apply to other footers, will have to implement
^[A-Z]*-by: logic that I have implemented for sendemail, in am as well.
I'll get back to that, but I think it's separate from this feature.

-- 
MST
