From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 13:46:31 -0800
Message-ID: <xmqq38n1guo8.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
	<CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
	<5281DB46.2010004@bbn.com> <5282977b2ecd_3b98795e785e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 22:46:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgLnU-0003nJ-47
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab3KLVqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:46:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab3KLVqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:46:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C861506C4;
	Tue, 12 Nov 2013 16:46:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZeiU5KB0UrOScFs3kKKea86FX4=; b=sgkGV4
	2iw5PkLDx5VgJ2e6Y0oLtl7QNhpgMWP50RC49OXgIe3Syg74BLNuKSf480+NUMz0
	IVtMjoFNRBhctKoJy94jqkHV99kzJuR6i8cxnL0wRJMVp0UW2dMeOiXfb/jKNQfA
	VJ1VGhd5kFv5UKKIRxxUZ5wWiqOsTuzyuUtDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0fdJdM3pWztks5+UJJ6/37TV62/HMLy
	hhyMlsrsoABZiX7EqN4PETtD2FWRKAJhJmZOpPjpWkMbc2tlOQ33+Odp6QIBCcJr
	klx24Y+otZpmyOz0l3Jdk269vV6CsoGUVC5stDaYxe7e4d7wUP24NzGEYLdGiY82
	JzalDPMeIe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32276506C1;
	Tue, 12 Nov 2013 16:46:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8163B506BB;
	Tue, 12 Nov 2013 16:46:40 -0500 (EST)
In-Reply-To: <5282977b2ecd_3b98795e785e@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 12 Nov 2013 15:02:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9EAC9E8-4BE3-11E3-A56C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237760>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Does it?
>
>  % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
>  % git fetch origin master
>  From /home/felipec/dev/git
>   * branch            master     -> FETCH_HEAD
>   * [new branch]      master     -> refs/remotes-test/origin/master
>
> In this case remote.origin.fetch is determining how to translate ref names, not
> what gets transferred, *exactly* the same as we are doing with --refspec. And
> as far as I know, remote.origin.fetch is a refspec.

If you had 'next' and 'pu' branches at the remote, do they get
fetched with that command line?
