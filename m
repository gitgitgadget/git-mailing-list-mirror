From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the
 operation
Date: Wed, 3 Aug 2011 15:34:35 +0200
Message-ID: <20110803133435.GA5186@elie.Hillsp>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-18-git-send-email-artagnon@gmail.com>
 <201107311751.52965.chriscool@tuxfamily.org>
 <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobb1-0007E0-MS
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab1HCNer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 09:34:47 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:53407 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab1HCNeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 09:34:46 -0400
Received: by wwg11 with SMTP id 11so3453990wwg.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m1bja2j3HQoEeUlJPdY0anK5MyZtCVmzqJ3ZPnAc/J4=;
        b=l9mvPjJmV3Fj5xDVkntImr5J45XxrF+dFZk/v0Re25FuyhA11SZyzI0QoWpAEZxSfN
         qg/CcPLDom9o4v/irVCeFv28BwWkXiMgnv57oYVOvjb2xD+In5ITAx9gq04h47w+tbEo
         JMbul1NrMgq4FhuOBr1ivieDveXyv1J72MQv8=
Received: by 10.216.54.134 with SMTP id i6mr654363wec.110.1312378484824;
        Wed, 03 Aug 2011 06:34:44 -0700 (PDT)
Received: from elie.Hillsp (94-194-201-239.zone8.bethere.co.uk [94.194.201.239])
        by mx.google.com with ESMTPS id fe4sm691699wbb.11.2011.08.03.06.34.41
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 06:34:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178574>

Ramkumar Ramachandra wrote:
>> On Thursday 28 July 2011 18:52:30 Ramkumar Ramachandra wrote:

>>> + =C2=A0 =C2=A0 for (p =3D buf.buf; *p; p =3D strchr(p, '\n') + 1) =
{
[...]
> Yes, that was intentional.  Every editor I know of inserts a '\n' at
> the end of the last line, and I've seen some applications warn/ break
> when the last line is not terminated with '\n'.  I suppose another
> reason to not change this is consistency -- we don't have to handle
> the last line using a special case.  So, I personally don't like it,
> but I'll add a special case if you insist.

What is the failure mode?  If it is a baffling segfault, then I
insist.
