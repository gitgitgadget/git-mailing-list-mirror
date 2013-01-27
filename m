From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] mergetools: Simplify how we handle "vim" and
 "defaults"
Date: Sat, 26 Jan 2013 19:15:17 -0800
Message-ID: <7vobgbz58a.fsf@alter.siamese.dyndns.org>
References: <1359247573-75825-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 04:15:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIic-0005wi-Co
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab3A0DPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:15:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:15:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172B8CDB6;
	Sat, 26 Jan 2013 22:15:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hH+Z7OXbYUWGiOkSWv7UIBOAfhQ=; b=VV6YD/
	9G9jQxbLEXZt1CLCK6BrcXZu8+eFLLpcnLE5qMEOg/yPqScylrYDT7T/Z2NVUlI3
	3Hl9eVG4eOITH0MN5UNE8vdF0FCj2AtMxeIUuptO7bPJiHHpRl+dmbXLxzvFjgOn
	hbKhLZuj54Nxc+WyL6hNwcJJxpMY+gmKeS3bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XAMCeOtk8VxqB7rvfPjSW83YTzgW8jyw
	JU+NaHoKjwUOTRjdyuLS/z2NlNZQagLLny/3FxNUk1ryFNAcbbnqu9o7OsqT8ING
	wCOJHv5dRyVpLqxhfdXLQkAWMjuSHAxlAT2TB5+ttf28PYoCZoen6vxzPhG3F6Ef
	6+/89AyJBiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D49BCDB5;
	Sat, 26 Jan 2013 22:15:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 949E8CDB4; Sat, 26 Jan 2013
 22:15:18 -0500 (EST)
In-Reply-To: <1359247573-75825-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat, 26 Jan 2013 16:46:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7032BFC-682F-11E2-9BBA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214662>

David Aguilar <davvid@gmail.com> writes:

> @@ -44,19 +46,9 @@ valid_tool () {
>  }
>  
>  setup_tool () {
> -	case "$1" in
> -	vim*|gvim*)
> -		tool=vim
> -		;;
> -	*)
> -		tool="$1"
> -		;;
> -	esac

This part was an eyesore every time I looked at mergetools scripts.
Good riddance.

Is there still other special case like this, or was this the last
one?

Thanks, both of you, for working on this.
