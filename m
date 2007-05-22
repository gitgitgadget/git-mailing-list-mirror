From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 5/5] Add --binary flag to commands that generate diffs
Date: Tue, 22 May 2007 13:15:13 +0100
Message-ID: <b0943d9e0705220515m7eb380cdw277847cf07382761@mail.gmail.com>
References: <20070519000451.4906.87089.stgit@yoghurt>
	 <20070519001012.4906.86287.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 22 14:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTGq-0001Wf-6d
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbXEVMPR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755918AbXEVMPR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:15:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26418 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872AbXEVMPQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2007 08:15:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so258854uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 05:15:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XS0mnIkSEGOENbeat13obdhviezW6nKHLlwNp6Tzb4HtjHiz6X5lfJ3cs3KWxMztIQEzjMHM4G6k8HthnryqmAGamCnNY4GsbmVlGoX/2jItWgycC+HH9TpZvPTFLu2xyQ6At407+MiJEy8hgMCi+8k1Egd4sES3ALel6bazlo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RdrNwLKYsNjQAB1AhzbRYozHZxRXB8uTNpOr4ulhTHfwjJVPlnV6xJ2nTAJZzIsTkfX1WBliaTsvhHONiF3h0k28Jyu2kSvHFKiUla84nZ0MNxYZi2Ci1TOkJ2CbLF9qCJcceeFlXWIofgAQ7XlYNLdO0YRYFB20xT2ZLbLURTE=
Received: by 10.67.98.9 with SMTP id a9mr547964ugm.1179836113734;
        Tue, 22 May 2007 05:15:13 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 22 May 2007 05:15:13 -0700 (PDT)
In-Reply-To: <20070519001012.4906.86287.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48097>

On 19/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> This just passes the --binary option to git-diff-*, which causes the
> generated diffs to contain an applyable diff even when binary files
> differ. It's necessary to do this if you want to mail patches to
> binary files.

I applied this patch but is there anything wrong if we have this
option on by default, at least for some commands? Maybe we don't need
it for 'show' and 'diff' but we definitely need it for 'mail' and
'export'.

There is also git.apply_diff() which calls git.diff(). This is first
tried when pushing a patch and followed by a three-way merged if it
fails. I think we should always have the --binary option in this case.

--=20
Catalin
