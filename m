From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: Reason for objects still being written with a failing pre-receive 
	hook?
Date: Wed, 24 Jun 2009 16:36:38 +0200
Message-ID: <9e0f31700906240736r50d2de51kc50822619ec619fa@mail.gmail.com>
References: <9e0f31700906240621k314b4bbehc283c8a1c673a2f1@mail.gmail.com>
	 <20090624135713.GE11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 16:36:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJTai-0000Gq-Js
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 16:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZFXOgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jun 2009 10:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZFXOgi
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 10:36:38 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:40983 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbZFXOgh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2009 10:36:37 -0400
Received: by ewy6 with SMTP id 6so1240234ewy.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 07:36:38 -0700 (PDT)
Received: by 10.210.59.14 with SMTP id h14mr1542821eba.63.1245854198862; Wed, 
	24 Jun 2009 07:36:38 -0700 (PDT)
In-Reply-To: <20090624135713.GE11191@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122140>

On Wed, Jun 24, 2009 at 3:57 PM, Shawn O. Pearce<spearce@spearce.org> w=
rote:
> Johan S?rensen <johan@johansorensen.com> wrote:
>> I'm wondering what the reason is that objects are still being stored=
,
>> despite a non-zero exit code from the pre-receive hook?
>
> The pre-receive hook is allowed to inspect the objects that have
> been uploaded in order to make its access decision. =A0Thus those
> objects must have been unpacked (or indexed into a new pack) so
> git commands in the pre-receive hook can read them.

Yeah, noticed that after I started digging into the code a bit

>> If it's expected and accepted behaviour, what other options do I hav=
e
>> to prevent a scenario like the above?
>
> There currently isn't a way to stop this, other than to use something
> in front of git-receive-pack, e.g. Gitosis, to deny even forking
> the receive-pack binary for the user.

Well, I already wrote such a thing (Gitorious.org) but I want to take
the auth a little bit further and offer some more fine-grained
access-controls and discovered the above during some smoke testing.

>
> --
> Shawn.

Thanks
JS
