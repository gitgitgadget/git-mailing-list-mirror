From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Wed, 02 Jan 2013 09:08:32 -0800
Message-ID: <7v623f4inj.fsf@alter.siamese.dyndns.org>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
 <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
 <20130102071701.GG20724@iris.ozlabs.ibm.com>
 <7vwqvw3v3o.fsf@alter.siamese.dyndns.org> <50E3E9C2.5040901@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Lukasz Stelmach <stlman@poczta.fm>
X-From: git-owner@vger.kernel.org Wed Jan 02 18:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRoF-0001md-K0
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 18:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab3ABRIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 12:08:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3ABRIf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 12:08:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7737BECF;
	Wed,  2 Jan 2013 12:08:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+8vnFs1/lZke
	4tBERPyYwTss3DI=; b=x32YaC6S3iBLXJQwl/WBljZh+QzgGydGHGHbTyyAh4NM
	woTe2ePZm+wkNydNfHVMh5Vk5J9CoDqhjCbAu7wbY+yjUArhSvJEFnUhy+iLLrr4
	yFkd46PfyGqKIbqct2tnSLc5AjJsPDI63DJNAcQtMEW1DkZDV6TBkZdASwZ4XR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r/VUFY
	/7qpwynZX1VerRRDgAYG42FUV1L8C1nxLCuEV+T147yTuimmkzDLhx6yNbNZWG3h
	m3RFy+fKeyMZDteg7phDkbn8GWZVNn+WvbaS1Bc9Zodq8SQmPK4ixTU6F3jMS8Nw
	ZU/5qTrYEGCm96oBRtWEq13onhcF8IG4FVTCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C84A0BECE;
	Wed,  2 Jan 2013 12:08:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D4DCBECD; Wed,  2 Jan 2013
 12:08:34 -0500 (EST)
In-Reply-To: <50E3E9C2.5040901@poczta.fm> (Lukasz Stelmach's message of "Wed,
 02 Jan 2013 09:03:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A5F0770-54FF-11E2-B9E3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212528>

Lukasz Stelmach <stlman@poczta.fm> writes:

> W dniu 02.01.2013 08:24, Junio C Hamano pisze:
>> Paul Mackerras <paulus@samba.org> writes:
>>=20
>>> On Sat, Dec 01, 2012 at 06:16:25PM -0800, Junio C Hamano wrote:
>>>> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>>>>
>>>>> Enable hiding of tags displayed in the tree as yellow labels.
>>>>> If a repository is used together with a system like Gerrit
>>>>> there may be quite a lot of tags used to control building
>>>>> and there may be hardly any place left for commit subjects.
>>>>>
>>>>> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>>>>> ---
>>>> ...=20
>>> If the concern is the amount of screen real-estate that the tags ta=
ke
>>> up when there are many of them (which is a reasonable concern), I'd
>>> rather just put a single tag icon with "tags..." inside it and arra=
nge
>>> to list all the tags in the diff display pane when the user clicks =
on
>>> it.  I think that would be better than not showing the tags at all.
>>=20
>> Yeah, sounds very sensible.  Thanks.
>
> I am afraid I don't really understand why tags should be listed in th=
e
> diff pane only after clicking the "tags" tag (if this is what Junio h=
as
> suggested)? How about just putting there another line saying: Tags, n=
ext
> to Parent and Chindren and all the stuff?
>
> If something should happen upon user interaction with the tag label a
> toolpit would be a better choince FWIW.

If you meant tooltip that shows extra information in a pop-up when
the user hovers the pointer, I think that would be a workable
solution, too, and probably is a better one, compared to showing it
in another pane that may or may not be selected.
