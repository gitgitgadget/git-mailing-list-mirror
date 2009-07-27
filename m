From: Geoffrey Irving <irving@naml.us>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Mon, 27 Jul 2009 08:48:34 -0400
Message-ID: <7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com> 
	<7vfxcku13i.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVPdX-0002NU-SY
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 14:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbZG0Msz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbZG0Msy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 08:48:54 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:61833 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbZG0Msy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 08:48:54 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1594742qwh.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ps4VuWzf78yeegO+BUzUUNpRTADLdt369SrpMztAqu8=;
        b=uy/8P4FxwjOPcMMkRxUOo/t1XiILowpFwKffLatNhbpNPHP99wjBOHIyz1OmmdUImK
         tcE1bJo7C1ck7qGshAfoZGTDawpGw6sVwPwXUeVKlbqBDXgyEpqI9mm/5LfMBeKWtmZp
         S2RaOLMMyMHpLdb8EUDVzbrhkFFFAq0BK9BYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=MO2ucSGj3JSJzNQkA62bwMaIJxaGQGMn2NHdchQ8n5pHTkFKAj077BXOEsmwJDplAR
         2H53TE/wPfXfFm9HcoDKkiCfbUJqfLiA2cuFs7LJDCMo21NOSoOVtbiFV6Xdlv5nV3o+
         yUFIB5h+Y+OxN2N6jC3a/bZ+12dAgWX7VzNEU=
Received: by 10.220.86.77 with SMTP id r13mr3327216vcl.33.1248698934109; Mon, 
	27 Jul 2009 05:48:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 7ab9ff3c383df9f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124165>

On Sat, Jul 25, 2009 at 1:44 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 25 Jul 2009, Junio C Hamano wrote:
>
>> Geoffrey Irving <irving@naml.us> writes:
>>
>> > @@ -504,6 +508,8 @@ int cmd_fast_export(int argc, const char **arg=
v,
>> > const char *prefix)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Import marks f=
rom this file"),
>> > =A0 =A0 =A0 =A0 =A0 =A0 OPT_BOOLEAN(0, "fake-missing-tagger", &fak=
e_missing_tagger,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Fake a tagger =
when tags lack one"),
>> > + =A0 =A0 =A0 =A0 =A0 OPT_BOOLEAN(0, "no-data", &no_data,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Skip output of b=
lob data"),
>>
>> Shouldn't this be --[no-]data option that defaults to true? =A0Other=
wise you
>> would accept --no-no-data that looks silly.
>
> Maybe
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_NEGBIT(0, "data", &no_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Skip output =
of blob data", 1),
>
> Hmm?

Not quite.  That produces

usage: git fast-export [rev-list-opts]

    --progress <n>        show progress after <n> objects
    --signed-tags <mode>  select handling of signed tags
    --export-marks <FILE>
                          Dump marks to this file
    --import-marks <FILE>
                          Import marks from this file
    --fake-missing-tagger
                          Fake a tagger when tags lack one
    --data                Skip output of blob data

I don't see similar uses of OPT_NEGBIT, so maybe the necessary option
case hasn't been written yet (or I'm missing something obvious)?

Geoffrey
