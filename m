From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: git-gui: textconv not used on unstaged files
Date: Tue, 27 Nov 2012 21:37:12 +0100
Message-ID: <50B52478.2070701@arcor.de>
References: <5088347F.50503@arcor.de> <50B3D0D2.6060308@arcor.de> <7vk3t8qe4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:37:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdRuP-0001mO-PS
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 21:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2K0UhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 15:37:16 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:41210 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755832Ab2K0UhP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 15:37:15 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id A49A0CBE34;
	Tue, 27 Nov 2012 21:37:13 +0100 (CET)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id A415128A880;
	Tue, 27 Nov 2012 21:37:13 +0100 (CET)
Received: from [10.0.0.1] (188-22-235-234.adsl.highway.telekom.at [188.22.235.234])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-16.arcor-online.net (Postfix) with ESMTPA id 4810A887C;
	Tue, 27 Nov 2012 21:37:13 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 4810A887C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1354048633; bh=N1crI+eZxsUqcsbwCMcgw6+6zmY7ygmsFLbCI4248aQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Cuml6kG4N+VWW/rfjNTrlFRMDLC+Zpmibmnf0RG5C5Am+IeHNWdj9zNDNeDBYJqeT
	 g75ARhIUEq7yUySHeKI1h+WiUXFsYjkVPIbAD43DmgGMwhAI9kL//5s9Gg95IXYilY
	 4d5eOpDxVLcJLkxqtVUynkfJCMg557GA6i1v2r4E=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vk3t8qe4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210592>

On 2012-11-26 21:54, Junio C Hamano wrote:
> Peter Oberndorfer <kumbayo84@arcor.de> writes:
>
>> Does anybody have a idea which git command would output the diff
>> of a untracked file against /dev/null?
> The "--no-index" option is meant as a bolt-on to let you use various
> features of "git diff" that is missing from other people's "diff" in
> a context where git does not know anything about that file.  It
> should be usable even outside a git repository.
>
>     $ git diff --no-index /dev/null new-file.txt
>
> I do not know offhand (and didn't bother to check) if textconv
> applies, though.  It does need access to a git repository as it
> reads from the $GIT_DIR/config to learn what to do.
Hi,

this seems to work when adding the --textconv option.
I will try to see if I can modify git gui to use this command
when clicking a unstaged file.

Thanks,
Greetings Peter
