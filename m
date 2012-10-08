From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposed function path_in_directory()
Date: Mon, 08 Oct 2012 11:23:44 -0700
Message-ID: <7vmwzwlt5b.fsf@alter.siamese.dyndns.org>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
 <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu>
 <7vd314gcti.fsf@alter.siamese.dyndns.org> <50692150.8080504@alum.mit.edu>
 <506FE619.1020608@alum.mit.edu> <7vy5jhlz70.fsf@alter.siamese.dyndns.org>
 <50731968.7020602@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHzh-0006rG-7z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab2JHSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:23:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab2JHSXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:23:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9B6962F;
	Mon,  8 Oct 2012 14:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NwnIl4uCvrE2Gjtm6wU+f0A4xr8=; b=LJQoQL
	/q6HMco/I2XEbWXOXyveXVRAT+mH34GQIhDICGqfEvWbd8yCgESgasEyG5Y+e0aG
	Uc/sg7KqpwI2HZCLMW93++DPKEKTuMBoGOtKDmsz2X1+OJNdkHJOl1u25VTJxGre
	MSkWpq/VoNcgG8rNVNyyJEkJFm6VxVTwFSgNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LxxGd329wIlS8IGk15ZfoLhsbNdhk0wn
	HNHAKsia295b38vganuIfHJOBtJn6LLgSr8+97LJKoXQN/2JqJeV4IiHtWwZ96HK
	w8DCr6ReJ40urgJPfVyiPuxRQ64S6D9Ze2z7kggULOilmsIaiii3AqJeH1uf+Z8A
	5llycs2UwYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A94D962E;
	Mon,  8 Oct 2012 14:23:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ACCA962D; Mon,  8 Oct 2012
 14:23:45 -0400 (EDT)
In-Reply-To: <50731968.7020602@kdbg.org> (Johannes Sixt's message of "Mon, 08
 Oct 2012 20:20:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BCD192C-1175-11E2-BCC6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207255>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 08.10.2012 18:13, schrieb Junio C Hamano:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> 2. Does there need to be any special related to DOS paths?
>> 
>> The ceiling computation may need special case for dos.  What does
>> the getcwd() give us?  Do we learn only the path within the "current
>> drive" and need to prefix C: (or D: or X:) ourselves if we really
>> want to tell C:\bin and D:\bin apart?
>
> We don't have to do that. getcwd() returns the drive letter.
> ...
> A component in an path list like GIT_CEILING_DIRECTORIES or PATH that
> does not contain the drive letter is a user error. Do not cater for it.

That makes it much simpler and saner.  Thanks.
