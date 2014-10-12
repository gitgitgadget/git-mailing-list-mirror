From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] fdopen_lock_file(): access a lockfile using stdio
Date: Sun, 12 Oct 2014 08:17:19 +0200
Message-ID: <543A1CEF.7020700@alum.mit.edu>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu> <1412162089-3233-2-git-send-email-mhagger@alum.mit.edu> <542D1AF2.8050508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 08:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdCTP-0007Z1-9f
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 08:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbaJLGR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2014 02:17:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56155 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802AbaJLGR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2014 02:17:29 -0400
X-AuditID: 12074413-f79bb6d000001e81-ce-543a1cf3c2c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 50.82.07809.3FC1A345; Sun, 12 Oct 2014 02:17:24 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97371.dip0.t-ipconnect.de [79.201.115.113])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9C6HKM8012321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 12 Oct 2014 02:17:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <542D1AF2.8050508@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqPtFxirEoPURk0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8WPlh5mi38Taiw6O74yOrB77Jx1l91jwaZSj4evutg9nvXuYfS4eEnZ4/Mm
	OY/bz7axBLBHcdskJZaUBWem5+nbJXBn3O+7y1qwULBi6ZvZjA2M13m7GDk4JARMJBp3Z3Yx
	cgKZYhIX7q1n62Lk4hASuMwocXbqPCYI5wKTRM//0+wgVbwC2hIrJ3SzgtgsAqoSa7fdYwKx
	2QR0JRb1NIPZogIBEh86HzBC1AtKnJz5hAXEFhHIkvj26QtYL7PAekaJBVf4QWxhAS+Jhgkt
	zBDLpjJKnFj4G2wZp4CaROfFVmaIBj2JHdd/QTXLSzRvnc08gVFgFpIds5CUzUJStoCReRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSCQI72DcdVLuEKMAB6MSD6/Ef8sQ
	IdbEsuLK3EOMkhxMSqK8tS+AQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4TYStQoR4UxIrq1KL
	8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8WdJAjYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgWI0vBkYrSIoHaG8vSDtvcUFiLlAUovUUo6KUOO8ikIQASCKjNA9u
	LCy9vWIUB/pSmPefFFAVDzA1wnW/AhrMBDT4aJc5yOCSRISUVAOj9mWNb7tss2YkrV+6Z0lQ
	T9unvxrvjxveM4uQDE94pP9j6YYkwcQv666uL/Sdzst5a+6LL6ZMVeWxc6YGmJW2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I see I never responded to this email.

On 10/02/2014 11:29 AM, Torsten B=F6gershausen wrote:
> On 01.10.14 13:14, Michael Haggerty wrote:
> []
> Nice done, small comments inline
>> diff --git a/lockfile.c b/lockfile.c
>> index d27e61c..e046027 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -7,20 +7,29 @@
>> =20
>>  static struct lock_file *volatile lock_file_list;
>> =20
>> -static void remove_lock_files(void)
>> +static void remove_lock_files(int skip_fclose)
> Even if the motivation to skip is clear now and here,
> I would consider to do it the other way around,
> and actively order the fclose():
>=20
> static void remove_lock_files(int call_fclose)

I don't think inverting the logic will help the reader remember the
motivation for skipping the call to fclose(). I think this way was
clearer because skipping the call to fclose() is the "unusual" case; it
has to actively sabotage the fclose() that would otherwise take place i=
n
rollback_lock_file(). Also, "call_fclose" slightly implies that fclose(=
)
will be called for the lockfiles, whereas in fact it will only be calle=
d
for the lockfiles for which fdopen_lock_file() has been called.

>>  {
>>  	pid_t me =3D getpid();
>> =20
>>  	while (lock_file_list) {
>> -		if (lock_file_list->owner =3D=3D me)
>> +		if (lock_file_list->owner =3D=3D me) {
>> +			/* fclose() is not safe to call in a signal handler */
>> +			if (skip_fclose)
>> +				lock_file_list->fp =3D NULL;
>>  			rollback_lock_file(lock_file_list);
>> +		}
>>  		lock_file_list =3D lock_file_list->next;
>>  	}
>>  }
>> =20
>> +static void remove_lock_files_on_exit(void)
>> +{
>> +	remove_lock_files(0);
> What does "0" mean ?
>=20
> remove_lock_files(LK_DO_FCLOSE) ?
>=20
>> +}
>> +
>>  static void remove_lock_files_on_signal(int signo)
>>  {
>> -	remove_lock_files();
>> +	remove_lock_files(1);
> And what does this "1" mean ?
>=20
> remove_lock_files(LK_SKIP_FCLOSE) ?
>=20
> We can even have an emum, or use #define

Meh. These are private functions, all defined within a few lines of eac=
h
other. I think that an enum would be overkill here when a "boolean"
suffices.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
