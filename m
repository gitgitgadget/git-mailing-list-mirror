From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 10/19] fsck: Make =?UTF-8?Q?fsck=5Ftag=28=29=20warn?=
 =?UTF-8?Q?-friendly?=
Date: Fri, 19 Jun 2015 23:06:08 +0200
Organization: gmx
Message-ID: <daaa8919802f7ace91cbc051bba6e42b@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <851b7fdb435c193abf0e20d0f0e171849e302aff.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqegl778pk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63UU-0001OG-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933555AbbFSVGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:06:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:63441 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933545AbbFSVGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:06:17 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZgdm-1ZPNYi3N8Q-00LVIz; Fri, 19 Jun 2015 23:06:10
 +0200
In-Reply-To: <xmqqegl778pk.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:UTOBrDuOSWSZUZerKWG8E2fY2ewt50qWNMpgPJ1FWuXy1kmdQ+v
 usWmb8oIyF3KvZSXt7+EPjX0hkoy3uRsFPRyZPbgATtXmj5bBFxL6WTJNHPnIFXpsGoF4di
 R6gbisfHkrDzIOPoJWvvZW9Ezn+aIBzMYhMkmxt3IV13nUDC7xRypR1FlpTctJwShGA63qk
 8CaiUiCCd8uvK1mNz/LUw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272208>

Hi Junio,

On 2015-06-19 22:18, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> When fsck_tag() identifies a problem with the commit, it should try
>> to make it possible to continue checking the commit object, in case the
>> user wants to demote the detected errors to mere warnings.
> 
> I agree with that.  But if FSCK_MSG_BAD_OBJECT_SHA1 is an ignorable
> error, why should we still have a conditional "goto done" here?
> 
> Shouldn't we be parsing the object the same way regardless?

Same reason as I mentioned before: in `git receive-pack --strict` we want to fail early, there is no sense to keep going when we know that nothing of the rest will make it to the server.

Ciao,
Dscho
