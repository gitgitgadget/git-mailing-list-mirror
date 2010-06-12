From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Sat, 12 Jun 2010 03:41:38 +0200
Message-ID: <201006120341.39843.jnareb@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com> <201006120301.37931.jnareb@gmail.com> <AANLkTimfzjZ00ua23FDmUJLil-_OEPEkiS73syVCQ52f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 03:41:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONFjI-0004AF-Ll
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 03:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab0FLBln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 21:41:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58570 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0FLBlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 21:41:42 -0400
Received: by bwz7 with SMTP id 7so717641bwz.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 18:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pcAOdgkXmq8YAFCpqv1WuFb6AO1Ha8LA4Kqkx7g+NuM=;
        b=aIJB5bx2pXeJOo0ziY+r3XMN4LJQ4nCR31uTxkckmQ7WSfND2L4nOfosv1bSsYG+kM
         Uin9lzjFuU1e8Sr/SaBuYSN4zFu8RVocSHk/JfC0k2zPE9HDipII1hmLtg1bNULn9/AL
         Vp+GtIdFTEoWcTosVXRNE05W2JViW3zdDXbPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CHDCheHhYzEClLOZ8tDMQ1IfzmoV8VT6DEqL8lz+QOvl51k6sxUFnNcVzWqNbKfBUW
         2Ask5mGpITEntrJ6PAfUvDsOCFkcfORtPyb7hJwmJwFWbqxBTqDH49o6VLnHQYcGdUqo
         d2RPDYq0mhtT2GWIdSZobxMf6MTqUHB044grg=
Received: by 10.204.81.222 with SMTP id y30mr1877982bkk.155.1276306901012;
        Fri, 11 Jun 2010 18:41:41 -0700 (PDT)
Received: from [192.168.1.15] (abrz228.neoplus.adsl.tpnet.pl [83.8.119.228])
        by mx.google.com with ESMTPS id v3sm7487186bkz.4.2010.06.11.18.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 18:41:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimfzjZ00ua23FDmUJLil-_OEPEkiS73syVCQ52f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148983>

On Sat, 12 Jun 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Jun 12, 2010 at 01:01, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> On Tue, 8 June 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> I haven't contributed to Gitweb, nor do I have to deal with it. But
>>> I've followed this series and reviewed most of the Perl code in
>>> Git. Take these with a grain of salt.
>>>
>>> It would be very useful for the future of our Perl code if we had a
>>> dual-life system in Git. I.e. a cpan/ directory where we could drop
>>> CPAN modules that should be shipped with Git.
>>
>> The standard name for such directory is 'inc/', I think.
>=20
> Perl itself uses cpan/, but Module::Install started the inc/. What we
> call it really doesn't matter though.

Right.

Although better example would be what modules on CPAN use, rather than
what Perl itself uses.

>>> Then we could just use e.g. Config::General (~3k lines of code)
>>> instead of writing our own config system. There are probably lots o=
f
>>> wheels that we're inventing (and are going to invent) that have bee=
n
>>> done better elsewhere, with more testing.
>>
>> The problem with _optional_ Config::General config is that people
>> would have incompatibile gitweb config files, some using Config::Gen=
eral
>> syntax, some current configuration in Perl.
>=20
> Isn't the current patch series the first attempt at config file
> support? I.e. it's always been editing the source until now.

Errr... no!

$ git blame -C -C -w -L/^our.*'GITWEB_CONFIG'/,+12 gitweb/gitweb.perl
shows that current config file in Perl (loaded using 'do $file') is
with gitweb since at least 2006-08-02.
=20
> In any case, proper non-executable config file support could easily b=
e
> made optional, hopefully with a transition the non-executable one.

I'm not sure if it would be easy to translate currently used gitweb
config files to non-executable file format.  I think that %feature
hash make it so such config format would have to support nested=20
structures, which means e.g. JSON or YAML.

Besides how would you store / define $export_auth_hook in non-executabl=
e
file format?

  # show repository only if this subroutine returns true
  # when given the path to the project, for example:
  #    sub { return -e "$_[0]/git-daemon-export-ok"; }
  our $export_auth_hook =3D undef;

--=20
Jakub Narebski
Poland
