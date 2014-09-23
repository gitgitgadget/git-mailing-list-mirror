From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 22:33:04 +0200
Message-ID: <5421D900.7060607@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>	<5421CAA6.3040107@redhat.com> <xmqqwq8ui00n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWlv-0006Gg-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbaIWUdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaIWUdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:33:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKX7EC021011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 16:33:07 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKX4LT003549;
	Tue, 23 Sep 2014 16:33:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqwq8ui00n.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257440>

On 09/23/14 21:56, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> What do you think about accepting only "/dev/null\n" and "/dev/null\r\n"?
> 
> I thought we agreed that what you are doing is not workable in the
> first place, no?
> 
> I suspect one way to handle "In this project, the files that are
> checked out must be with CRLF line endings no matter what the
> platform is" might be to use the line ending attributes to force
> that while keeping the in-repository data with LF line endings.  The
> diff output (format-patch output is just one of them) comes from
> comparing the in-repository representation, so you won't have \r\n
> that will be stripped via MTA in it, "apply" and "am" will apply the
> patch without having to worry about \r\n, _and_ the line ending
> attributes would end the lines in your in-working-tree files with
> CRLF that way.

This would be a perfect solution if the git repository was not a mirror
of a Subversion repository that contains all files with embedded CRLFs.

Anyway I accept defeat, thanks for your time.

Laszlo
