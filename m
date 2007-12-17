From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Fix config lockfile handling.
Date: Mon, 17 Dec 2007 11:24:43 -0500
Message-ID: <1197908683.8688.0.camel@hinata.boston.redhat.com>
References: <1197665998-32386-1-git-send-email-krh@redhat.com>
	 <1197665998-32386-2-git-send-email-krh@redhat.com>
	 <7vfxy5os60.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4J4R-0002Dk-By
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760620AbXLQQni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755662AbXLQQni
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:43:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556AbXLQQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:43:37 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBHGOncS028502;
	Mon, 17 Dec 2007 11:24:49 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGOmlX004657;
	Mon, 17 Dec 2007 11:24:48 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBHGOmpJ019816;
	Mon, 17 Dec 2007 11:24:48 -0500
In-Reply-To: <7vfxy5os60.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68579>


On Fri, 2007-12-14 at 13:57 -0800, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > When we commit or roll back the lock file the fd is automatically c=
losed,
> > so don't do that again.
>=20
> With your change, we do not check the return status from close(2)
> anymore, which means that we may have run out of diskspace without
> noticing and renamed the incomplete file into the real place.  Oops?

You're right of course.  Ok, so lets just stick with the current config
file handling for 1.5.4, it's not seriously broken.

Kristian
