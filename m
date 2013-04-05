From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 02/12] pretty: share code between format_decoration
 and show_decorations
Date: Fri, 05 Apr 2013 09:57:35 +0200
Message-ID: <515E83EF.3070609@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com> <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-3-git-send-email-pclouds@gmail.com> <7vd2uejfxr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 05 09:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO1XH-0003cE-1O
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 09:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765102Ab3DEH5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Apr 2013 03:57:42 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:34539 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765084Ab3DEH5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 03:57:41 -0400
Received: by mail-ee0-f41.google.com with SMTP id c1so1315869eek.28
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=XHdTe33Msd/nlC5xS+NWiXqqY82zDrloTzSJhbQtjbY=;
        b=FKTOEPLMrlgecow2Kbd92N3tESYBCFnpasnb618xOcchYQ5Zj47DZGJ22A3UbBotlD
         zxluY9//PW/sqosJjAqzkGjUBsb8LqtF0EuXBv9Dz1HGbReLMZtp4mX/n4FMJLINqTwp
         LvK3QhrL+zDNR7PHIyCCokTVcqTnfzuvXOpdSmVJZqClFLnuiTC9GvvBujd+nJxNHHw2
         MgmkYHg/VZIvVQZKr8CR90T93kIuDvKEHmz8MoIONW4L8utypGzwqZcXXo4P7/Txj2ZX
         485TjAR9h7aZi0Y0a3/nb+1p39mNDRMyJhJvaB8tUcHxzyATQag2MXk8BIpizRdOlhA4
         Cvbw==
X-Received: by 10.15.32.67 with SMTP id z43mr7958258eeu.24.1365148659950;
        Fri, 05 Apr 2013 00:57:39 -0700 (PDT)
Received: from [192.168.1.14] (dds23.neoplus.adsl.tpnet.pl. [83.23.96.23])
        by mx.google.com with ESMTPS id r4sm13957137eeo.12.2013.04.05.00.57.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 00:57:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vd2uejfxr.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220156>

Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:

>> diff --git a/log-tree.h b/log-tree.h
>> index 9140f48..e6a2da5 100644
>> --- a/log-tree.h
>> +++ b/log-tree.h
>> @@ -13,6 +13,9 @@ int log_tree_diff_flush(struct rev_info *);
>>  int log_tree_commit(struct rev_info *, struct commit *);
>>  int log_tree_opt_parse(struct rev_info *, const char **, int);
>>  void show_log(struct rev_info *opt);
>> +void format_decoration(struct strbuf *sb,
>> +		       const struct commit *commit,
>> +		       int use_color);
>=20
> I think you can fit these on a single line, especially if you drop
> the unused variable names (they help when there are more than one
> parameter of the same type to document the order of the arguments,
> but that does not apply here).  That would help people who run
> "grep" on the header files without using CTAGS/ETAGS.

Well, I think "int use_color" should be left with variable name,
don't you think?

--=20
Jakub Nar=C4=99bski
