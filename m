From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 12:50:43 +0200
Message-ID: <51D40203.1010100@alum.mit.edu>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com> <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com> <7vli5ogh8r.fsf@alter.siamese.dyndns.org> <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com> <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com> <CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 12:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKeC-0000Jp-W7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 12:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab3GCKus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 06:50:48 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59395 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753737Ab3GCKur (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 06:50:47 -0400
X-AuditID: 12074414-b7f626d0000001f1-b3-51d40206c350
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.AF.00497.60204D15; Wed,  3 Jul 2013 06:50:46 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r63AohMI023935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Jul 2013 06:50:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqMvGdCXQ4PcBXYuuK91MFg29V5gt
	5t3dxWTR33GZxYHF49LL72weFy8pezxcs4DN4/MmuQCWKG6bpMSSsuDM9Dx9uwTujGNr1jAW
	nOWuWH/sNmMD40bOLkZODgkBE4lXm58xQthiEhfurWfrYuTiEBK4zChxdksfM4RzlUmic/pW
	FpAqXgFtiYs7mphBbBYBVYnnUxaygdhsAroSi3qamboYOThEBcIkrvxWhSgXlDg58wlYqwhQ
	+Y7Hv8DKmQVKJSZ/+c8KYgsL2Ens2DwJavEOZoltv7+zgszhFAiUOLelEMRkFlCXWD9PCKJV
	XmL72znMExgFZiHZMAuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJT
	SjcxQkJZZAfjkZNyhxgFOBiVeHgdnl0KFGJNLCuuzD3EKMnBpCTK2/73cqAQX1J+SmVGYnFG
	fFFpTmrxIUYJDmYlEd6Jf4ByvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIc
	HEoSvGKMVwKFBItS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRGl8MjFOQFA/QXnaQ
	dt7igsRcoChE6ylGXY4DP7a8ZxRiycvPS5US5/3DAFQkAFKUUZoHtwKWuF4xigN9LMwrCzKK
	B5j04Ca9AlrCBLREevklkCUliQgpqQbGkhnPurd+F+wI5go9OrOZXebzG/sp2/Zp9f3LWxE8
	Ra4rIiUrW5O/P1b5quGRvyI2k7NtzpxyjPf5WJnGeu+pWN7t1IU117Udp+jkrU2I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229489>

On 07/03/2013 12:11 PM, Johan Herland wrote:
> On Wed, Jul 3, 2013 at 12:06 PM, Jonathan del Strother
> <maillist@steelskies.com> wrote:
>> I'm struggling to think of instances where I wouldn't want this
>> CAS-like behaviour.  Wouldn't it be better to make it the default when
>> pushing, and allowing the current behaviour with "git push
>> --blind-force" or something?
> 
> I believe I agree with you. I guess the reason this hasn't come up
> before is that by far most of the pushes we do are either
> fast-forwarding, or pushing into a non-shared repo (e.g. my own public
> repo),  and this safety only really applies when we're forcing a
> non-fast-forward push into a shared repo...

I didn't see Jonathan's original email but I was having exactly the same
though as him (and was even going to propose the same option name).

Non-ff pushing without knowing what you are going to overwrite is
irresponsible in most scenarios, and (if backwards-compatibility
concerns can be overcome) I think it would be quite prudent to forbid a
non-ff push if there is no local remote-tracking branch that is
up-to-date at the time of the push.  Circumventing that check should
require some extra-super-force option.

So yes, I very much like the general idea of the RFD and personally
would lean towards making it stronger and default, at the 2.0 transition
if necessary.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
