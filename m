From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 15/20] transport-helper: use the new done feature where possible
Date: Mon, 4 Jul 2011 15:37:41 +0200
Message-ID: <CAGdFq_gknRaWzZjOOZyE9WvgTLBGADDLb_WcxE3vfN+uRBztGw@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-16-git-send-email-srabbelier@gmail.com> <20110620114556.GA29818@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 15:38:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdjM3-0006WP-TB
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 15:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596Ab1GDNiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 09:38:22 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55542 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab1GDNiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 09:38:21 -0400
Received: by pzk9 with SMTP id 9so1686819pzk.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YwVS2bgWv0/0+DMLQHJZvUFs8cD5EtHNT2nNQAViVnM=;
        b=wYK0eFswg4tsDze85r4CRKRqZ3jkNkY2JI2+qvK3hgASV+m/5aiqKPLL67SlpS+vOT
         J16s7En7AvJ6gr6POXC3hwwcudtQ/Ai+3vvTY2LeZ3FYKgDWGFZmay65VfnDdF35m9tw
         NHaAwYmDpwHHQ6qAMu+sehpPA33omIZDrjQXY=
Received: by 10.68.20.4 with SMTP id j4mr7691912pbe.301.1309786701103; Mon, 04
 Jul 2011 06:38:21 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 06:37:41 -0700 (PDT)
In-Reply-To: <20110620114556.GA29818@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176598>

Heya,

On Mon, Jun 20, 2011 at 13:45, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> What is this change about? =C2=A0Is the plan to allow other commands =
after
> a fetch_with_import? =C2=A0Sounds reasonable; I think it should be
> advertised in the log message, though.

Yeah, the order/granularity of these commits is perhaps suboptimal.
The actual changes is by now explained in "export is no longer always
the last command" and "change import semantics". Perhaps they should
just be squashed together?

> The disconnect_helper call writes the blank line that terminates the
> list of "import %s" commands to start the import, so there would need

Terminating the list of import commands isn't needed until the "change
import semantics" commit, in which a write_constant(data->helper->in,
"\n") is added.

--=20
Cheers,

Sverre Rabbelier
