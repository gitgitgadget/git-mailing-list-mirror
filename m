From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH 1/4] rev-cache: basic implementation + full docs + 
	tests
Date: Fri, 3 Jul 2009 23:43:27 +0200
Message-ID: <81b0412b0907031443r1c49e8c4r598b3cf16eb641a8@mail.gmail.com>
References: <op.uwhy8r14tdk399@sirnot>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>, Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 23:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMqXj-0005Ki-Nu
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 23:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZGCVn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jul 2009 17:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZGCVn0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 17:43:26 -0400
Received: from mail-bw0-f207.google.com ([209.85.218.207]:44263 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbZGCVnZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jul 2009 17:43:25 -0400
Received: by bwz3 with SMTP id 3so588170bwz.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VJfQoWAJpMU3EyP7MZnie8cdDviMjBwLGwrijbsp4vs=;
        b=nzEQHXn7ipgJuzF6L9uDmwON5X5OTRKBCyXtnohQgXpx3jZM9/PWq6wGkE/vyHlz52
         qvFfS2NiBth9IWUhkvFsVMCKnHo8YyONadVhPnYts73fhDA7SGi+hNNuRWhroXg+rCNK
         Pv56Eip+RBiuutL+Ztma+erpfgnX5Wo0jycMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zg19WlTuNzTxyaGfjs8lx5hzRbqO9k5s1ZBRk9PJor09BUIeKqn0KvqtF7EA+zw+/s
         DFEdFaFn3/p+i/vnohQQMX4mqoj6CVBvdqCFbaXjZ/3sh2TamvBEgUyjKRbFjXGmgoQD
         0Junf7/KasEDibIr+N3GEmY+Z5jHUluubsiSo=
Received: by 10.204.59.76 with SMTP id k12mr1696385bkh.136.1246657407718; Fri, 
	03 Jul 2009 14:43:27 -0700 (PDT)
In-Reply-To: <op.uwhy8r14tdk399@sirnot>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122709>

On Fri, Jul 3, 2009 at 17:13, Nick Edelen<sirnot@gmail.com> wrote:
> Traversing objects is currently very costly, as every commit and tree=
 must be loaded and parsed. =C2=A0Much time and energy could be saved b=
y caching metadata and topological info in an efficient, easily accessi=
ble manner. =C2=A0Furthermore, this could improve git's interfacing pot=
ential, by providing a condensed summary of a repository's commit tree.

Do you have any benchmarks? How much improvement does it
mean for _common_ operations?
