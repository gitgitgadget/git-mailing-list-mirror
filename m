From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign 
	vcs
Date: Tue, 11 Aug 2009 17:31:50 +0200
Message-ID: <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
	 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MatKS-0000RQ-1E
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbZHKPbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbZHKPbu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:31:50 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:57272 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZHKPbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:31:50 -0400
Received: by fxm28 with SMTP id 28so1600144fxm.17
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZobHx2FTRL26U4KYkk28FzG3rNWlfQpYDEuW1S86fk4=;
        b=cWXYPUNfAcmHG/PdFyx5WlV2IlTaCpIYqZPtv5bTKgjkHQisrKSQcOXbyaNyUBJbS8
         Hy/pvm5HxdQv2n3tWEp2wyqL1Od6urYXCWBs7It156fbUhHsHQ4bPl05vmqR/24gt8Y5
         of5Q4nkEHtXsOLTR96ybPDyydTAVgJjZ+gXKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rW8PoM4QXdZ1jvLd3CZOaBZs4LNBKkDq/8uQWv0kzs647OQa0MIIWHKvg+OB5kw0bJ
         6wf3OH1adN7FneJe/rRWaY9GtM98WEUpmBDluphqFO4B4p1XviJQxmIKf1oPsb+nHFEQ
         zAnth42oCnRiRhGqrysJ9XECSvItsJpi+WM5s=
Received: by 10.223.121.136 with SMTP id h8mr766474far.26.1250004710498; Tue, 
	11 Aug 2009 08:31:50 -0700 (PDT)
In-Reply-To: <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125573>

On Mon, Aug 10, 2009 at 03:15, Junio C Hamano<gitster@pobox.com> wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> If this is set, the url is not required, and the transport always uses
>> a helper named "git-remote-<value>".
>>
>> It is a separate configuration option in order to allow a sensible
>> configuration for foreign systems which either have no meaningful urls
>> for repositories or which require urls that do not specify the system
>> used by the repository at that location. However, this only affects
>> how the name of the helper is determined, not anything about the
>> interaction with the helper, and the contruction is such that, if the
>> foreign scm does happen to use a co-named url method, a url with that
>> method may be used directly.
>
> Personally, I do not like this.
>
> Why isn't it enough to define the canonical remote name git takes as
> "<name of the helper>:<whatever string the helper understands>"?

May I ask what will happen to these supported URL notations:


       o   [user@]host.xz:/path/to/repo.git/

       o   [user@]host.xz:~user/path/to/repo.git/

       o   [user@]host.xz:path/to/repo.git

this will bite you, if you have an ssh host alias named "<your
favorite helper name>".

Bert
