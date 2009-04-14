From: Patrick Berkeley <patrickberkeley@gmail.com>
Subject: Re: On Tracking Binary Files
Date: Tue, 14 Apr 2009 15:44:26 -0400
Message-ID: <7efce40a0904141244n281353f3q716071d4fff5a7a0@mail.gmail.com>
References: <7efce40a0904140741w28da9b54ucfe4b54bf48b0844@mail.gmail.com> 
	<7efce40a0904140742i48aad41ds66de5dfe368f3b16@mail.gmail.com> 
	<alpine.LFD.2.00.0904141532160.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 21:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtoaF-0003qx-Ly
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 21:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbZDNTon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 15:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbZDNTom
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 15:44:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:41111 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbZDNTom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 15:44:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2803296ywb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Wag1pUwh+s2iSsw4bHJlSk189s1MeBn3Dj5ZdIVOF5I=;
        b=LE7LMnk75hEjvNcEtnGhSLQpd0UoysQ0kpP4Ouu0Dehxw4jwNzV8fvE3efhOr+yVJh
         Noas+IiYrbIdzEFq/5P/VYOK/I1FD+H3IsGCMG867EoumYBhV5dNm/esDqt/HhvyXfRm
         gt4dBCgTT1ZGqm7UauxURxK9XbuJRMqhZ2byg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=O4PCr6Fah/8SIuXyMg/T3t+WPRmyvw+vWxZaHkBgiAcwyhzuL8GmDvXqrEumN3bbrA
         lmTaoYr3U6kFaLb7ym3K8M4fuxfB5YxWP7BubdTiS2nGxfP0/SVAyGoGlTDMies7/BNN
         f9hHfXdWbCkIhf1kqwQqGGarxfSQ60LQLqFh4=
Received: by 10.150.144.17 with SMTP id r17mr11089619ybd.240.1239738281107; 
	Tue, 14 Apr 2009 12:44:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904141532160.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116561>

Thanks very much for the explanation .


On Tue, Apr 14, 2009 at 15:42, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 14 Apr 2009, Patrick Berkeley wrote:
>
>> Does Git track the deltas on binary files?
>
> Yes. =A0And actually git's delta storage doesn't care at all whether =
a
> file is text or binary.
>
>> Someone in #git mentioned that if the binaries change too much Git n=
o
>> longer just stores the changes. If this is the case, what is the
>> breaking point where Git goes from storing the deltas to the entire
>> new file?
>
> If two versions of the same file are simply too different to make del=
ta
> compression worth it, then no deltas are used. =A0It is still possibl=
e
> that a third version of the same file would produce a nice delta agai=
nst
> either the first or second version though, in which case that third
> version will be stored as a delta. =A0And so on.
>
> A sophisticated set of euristics is applied to the list of objects as=
 a
> whole to determine the best delta arrangement possible. =A0So there i=
s no
> such thing as a simple "breaking point".
>
>
> Nicolas
>
