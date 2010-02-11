From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v2 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 	support
Date: Thu, 11 Feb 2010 23:59:29 +0900
Message-ID: <4B741B51.5050304@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>	 <1265899135-11488-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, gitster@pobox.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 11 15:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaVy-00087O-UH
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab0BKO7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:59:32 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64299 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab0BKO7b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:59:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 5ED19EAF8D6;
	Thu, 11 Feb 2010 23:59:30 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcQmvS7HMCIh; Thu, 11 Feb 2010 23:59:30 +0900 (JST)
Received: from [192.168.11.2] (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id EA08AEAF8D1;
	Thu, 11 Feb 2010 23:59:29 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139603>

(2010=E5=B9=B402=E6=9C=8811=E6=97=A5 23:55), Erik Faye-Lund wrote:
> On Thu, Feb 11, 2010 at 3:38 PM, Hitoshi Mitake
> <mitake@dcl.info.waseda.ac.jp>  wrote:
>> @@ -1101,6 +1190,7 @@ static struct store *imap_open_store(struct im=
ap_server_conf *srvc)
>>                 }
>>   #endif
>>                 imap_info("Logging in...\n");
>> +
>>                 if (!srvc->user) {
>>                         fprintf(stderr, "Skipping server %s, no user=
\n", srvc->host);
>>                         goto bail;
>> @@ -1258,6 +1375,7 @@ static int read_message(FILE *f, struct msg_da=
ta *msg)
>>
>>         msg->len  =3D buf.len;
>>         msg->data =3D strbuf_detach(&buf, NULL);
>> +
>>         return msg->len;
>>   }
>>
>> @@ -1307,21 +1425,10 @@ static int split_msg(struct msg_data *all_ms=
gs, struct msg_data *msg, int *ofs)
>>
>>         msg->data =3D xmemdupz(data, msg->len);
>>         *ofs +=3D msg->len;
>> +
>>         return 1;
>>   }
>>
>
> There's not much point in having three hunks with a single added
> newline in each...
>
>

grr.. sorry, it is completely my mistake.
I'll send v3 later.
