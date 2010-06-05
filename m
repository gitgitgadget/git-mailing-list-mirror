From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with
 gettext
Date: Fri, 4 Jun 2010 22:36:26 -0500
Message-ID: <20100605033626.GA2252@progeny.tock>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
 <1275704035-6552-2-git-send-email-avarab@gmail.com>
 <20100605025702.GA2019@progeny.tock>
 <AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 05:37:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKkCp-0001CZ-CC
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 05:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0FEDgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 23:36:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43229 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab0FEDgf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 23:36:35 -0400
Received: by iwn37 with SMTP id 37so1712141iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 20:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ssPQ2VCk8F6VoW1Nxd4ysjRUFTyUrepqd1SncSoSpbE=;
        b=raazLN5aMSC6036VclilS4I7Uj09yuXufWvXeQHDqVS+h2wEgv8wlTxIsPDUn6BnvY
         7NUoJ4ctC13qaNFaWNNJQfpBgHfaX9LkAeEi7ix5OJnAfKLKoBXk4LvXd0iiFyb9/4um
         NznhJJobz9giTJvB8XzB4Oa4g+AC8VbzycaZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aYk7MuBntqpT2djfuFkEHvRNmOW/zazLSB35hTbVqDkGT2vGvBRgUknbwBL2DDJ/nF
         1JvaTGarAX+Povu6KrPWZIjtTlZLtEObu2M27Jmi0mDDykeLmMWteUkcVjaulMit+HUk
         eB2U3miN2r7N/56bUBJ6ejlLHikCUeQzHZC28=
Received: by 10.231.123.141 with SMTP id p13mr1731251ibr.174.1275708992727;
        Fri, 04 Jun 2010 20:36:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm8380234ibg.9.2010.06.04.20.36.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 20:36:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148455>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Jun 5, 2010 at 02:57, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> This handles builtins. =C2=A0=E2=80=98grep PROGRAM_OBJS Makefile=E2=80=
=99 reveals nine
>> other source files with their own main() functions.
[...]
> They're mostly guts, but I guess imap-send should be translated.

Ok, I just wanted to make sure it was intentional.

Is the porcelain/plumbing distinction meant to be honored here?
It is possible the right thing to do would be to have run_builtin()
call the function that calls setlocale(), if and only if the command
has a USE_LOCALE flag set.

The downside: this would make the handle_internal_command table even
wider than it already is.

Jonathan
