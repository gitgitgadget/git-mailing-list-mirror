Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F03211
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991986; cv=fail; b=hklKcKI/GDI52almr1Nj2q/tlXZskxvhrwjhpKWQcR19sbdTlKlOMhcRJJyQTl7RZY1skY7vp1l8i93liB6Ks2Oija9FUwsgBfV+zOGKRT4SBDAtyUJSYNoLZjcdvETXaOErrG6W1Bq8SzfmnywtxSsIWlfk3mPombTrRU0C8zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991986; c=relaxed/simple;
	bh=jaP8IPuZAtKSTCB8o2VQ3/aIEGQRcgiz905ykkgjwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twuh6LaxVDyNXiyee4rffIBLovzrL7Q8b4bfjrqs9LvVT8hXumfUTQJ+eDYIoRbFQRTlsR4FmgW6YpTTMVt1BYNtW2Uri3TdQEZkDkauF9JC78075aWiwnbOXl2Yg9FsMKzoxgkiPwKlESkvE++STPIHGfldfY/3yJYza6xpuvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=ug3/VRuc; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=sJg3hVjl; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="ug3/VRuc";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="sJg3hVjl"
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44I0J8BJ023958;
	Fri, 17 May 2024 17:26:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=2RJfyUgxzOCYl9xGSMOHwwJ2zgNUWw3J3/radunfKN0=;
 b=ug3/VRuclXshwQG24y7b38qJvYLPgtIRJrXOWdaN7aa4X0wVGRjROzJ1CCkPDUXAiTQ/
 RS2mr2EETC9zKny88+2mzm2VTyxxpU93+AtPhDiBwscZAXAthDWQ7K9nURj3YiDgoYRN
 wSv1oVwGtvuTyDB3JliIjBykXBWeV1cbiqOoOLaArttIQzLPYDQY2aPpogR0qTZ72bcO
 /rM4UDPjLQE1+Zsh+fef6cvHfMLMemn8OP0jtULfPbKXluDa+5SQ+7Zst4R9EqQ6V/xl
 shC+3dwWhnAO2Gad8+7gK2KPKOwWpyTuoh5M0q/mqvZzuS7HXFt5CE1WhySIyw7xFxWt NA== 
Received: from sa9pr09cu002.outbound.protection.outlook.com (mail-southcentralusazlp17012019.outbound.protection.outlook.com [40.93.14.19])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3y6b3mhasw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 17:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEljfojT745oiY1a8yxHtVOO2bidiCqncuJYHQfo58ljoQJ/pdQps2aOiKdWlCrB/h55WrFQD0+uFmv/yzOCFRPadEG5AlnQA9RFaplyOF1CA8PZ2pM9qVv4IFXibKMgLkfpSUNLif8uTEFZM14FPzJ2B1ZJU93iGmsyuuUyYCIBAuveNoiwPwva9lJngHXppQ909yiJcpW8mkMFyKh184gaY3cmur1Cg6IxUQtaaNLUQqbBayDe6HX+TRlqah598TjHbpMXN3UFI8xw64ep/kEGN7tzVIs76DVwG/e4sdlCaeG6PNcPWFrfrMfYJNurL1ALz4mdkzOPQb1MuoI0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RJfyUgxzOCYl9xGSMOHwwJ2zgNUWw3J3/radunfKN0=;
 b=CUjCh4SqPTR+zwivnRr14NTGT6MJDRZ7Emyf1Hen+YvLUfvkq0zxlsbVxpDBvxA83AWGjZWo09UDfnxS9g1sk3/dDChSrwxBEuz/ShdHgbU4750kRatGZSGNagxRQIImRz9cyY7mTzhzlEIsJ3gH/mlbRuKRlLLRihwF5/8rT1OKAk14dwIoR1UFIllaY33wvHh9e4FyrZ86TPDPYVcEVOnMmXBuqkzm9nwdwC8xkBZUT8jcR06QSq3E0g+j8YRdDG81eqwjRObDjbe3kt6pb3vav5LQoEtmeX7+r+IOKkgTKXCjj9OcnY7n+UY96S5Pj7A7Lug0ZrZTje9sW/WiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RJfyUgxzOCYl9xGSMOHwwJ2zgNUWw3J3/radunfKN0=;
 b=sJg3hVjlp+OXtZwC4lTdldVKgo82Ns3xxXvuujGOnrYiGuCUZ2W/GzbF9kJK56Sbs8jjVjN6JVRzWrSyR2o/k6dVCLNv04eJHue8ZXlJ9XHH7R6+o+wmf5OgUVUer2FVSldnIWmD2Hp8843OAJhfSz6vajy/cEl03Gfat4YPoYo=
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com (2603:10b6:a03:259::8)
 by SJ0PR09MB11417.namprd09.prod.outlook.com (2603:10b6:a03:50a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 00:26:09 +0000
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0]) by SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0%4]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 00:26:09 +0000
From: Tom Scogland <scogland1@llnl.gov>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
Date: Fri, 17 May 2024 17:26:08 -0700
X-Mailer: MailMate (1.14r5937)
Message-ID: <176A8590-61BC-45F2-9B37-FFD8B07ABCA9@llnl.gov>
In-Reply-To: <xmqqv83cdneo.fsf@gitster.g>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
 <xmqqv83cdneo.fsf@gitster.g>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To SJ0PR09MB7071.namprd09.prod.outlook.com
 (2603:10b6:a03:259::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB7071:EE_|SJ0PR09MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 965bc5d5-b603-4c1c-7844-08dc76d11d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tIxbK8G5CxHNDPYtoCCUIrJv13jYr4e1xakk+cclGtm7OOGM9s0oOKuVC3et?=
 =?us-ascii?Q?HYWhg78SbRNEZSWtz61va5ullUe07OvrxrtD+Ly5FE4HpKWLSAKVQQqd4c/G?=
 =?us-ascii?Q?iz/R4plirwtfadjUE35m1Rlj6nOJnPrTUCgD68DayUNaWG/8LCPhGDfA52I5?=
 =?us-ascii?Q?HOIeR39BXCm/VRAJhWi7v06QwKL99c0YKy1q7sxJi33mLvA5dbbRSmOQT4Bm?=
 =?us-ascii?Q?lV/xkiBW5Hza621PFbL7kjAuhzmv66QD488UkoaJ9zvYpD9rSjhyNYFqr496?=
 =?us-ascii?Q?OFlNdcQsnb4Ic+0bDPPPCWz+PuxV1eA9j7A9DvbXc/5DAWdXUUu8JyzykiLH?=
 =?us-ascii?Q?u952S5ltGov/ERw+S1SDLmGbhz8HjuwggABJd2rmvfmC7dozo43p+e3WbeAt?=
 =?us-ascii?Q?JszymsuJfHMKeHsTxVajvPUx/Z/Mrbijf44Lw10SzoSUKmdDFX7rMqK0n+1c?=
 =?us-ascii?Q?BM8dEzg1bjHy53CVFJz0AfIo8tjALl+paveQ4pVPqyKksViblLGEHLKGAQAw?=
 =?us-ascii?Q?iParpyvvu+2jGgGZaMFe9RreUyEZnHokxlpoiZOl9Oq+5btg6GwfF5LzI9gG?=
 =?us-ascii?Q?LlC/0s9DgIf9OLPlnk/sCxOkG6E2qp0F9amIvAta1JbKmy3tHlSIcVg3KWMi?=
 =?us-ascii?Q?dn0sN24BmM23XRdSrx+XKLXvZ8gjYVCmIYFlVj7T/5dtvaqdy9OfAIw93Xej?=
 =?us-ascii?Q?RrKhKCskLH+ZfcCfDGScmFnPuWVyak5VX2W8BcokqXfbF/Hzcwe8dvpAT5LR?=
 =?us-ascii?Q?6sVzUY47VvhInWq71cVpH6ubyfwDHQ4ZF7XcUT7g8oY24971IVQFRZBANf+g?=
 =?us-ascii?Q?kA6Q5nkoV+62jLx8UFIjAJ3KuN6SJ075O/MOy9DuqiAdfLd0ex358GyrVDTe?=
 =?us-ascii?Q?znMns4PR1Obztf9zt7/Q9JmNktrNv99CMXh7aKXL7wPlP8IN26ZoJLwpxXZR?=
 =?us-ascii?Q?awUYpqIowE2sDUQI0v54/hEwpBlYFvRV+urOendp+t6lmASNw+AaJIfZHq/a?=
 =?us-ascii?Q?GavQCg9cWRlJEzzQ8tjjjH5oIBYH3YFJ3Rs3NK96jJofQQpfe9zA+dVNwt9K?=
 =?us-ascii?Q?tQ8osiyf4vemDyvoPGLd8/qIncrmCnV6KZ0QeMtU3+d1sZmY3TLHyG2cOp0v?=
 =?us-ascii?Q?uY6fiGqHOQMn6fpdF23rdtG2Ffpdkt2LQeN12dmWAl+f0ll7+mSrz3iWPwBS?=
 =?us-ascii?Q?BCFszIrCx9G5TXikxgiBmnDHblPTN5Xmk+Empxot0ijCMbAQpWGKZhGzEzIb?=
 =?us-ascii?Q?5N1/4YSSn8M2z8hzdvs72+F3g/iu2pfvhBkqTq9xYg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB7071.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2k9yhD/cT0vj2ORIRBqOdfLBawSgJx8bAeBajP671f4Q8n+j2wlNG2oJMAX3?=
 =?us-ascii?Q?SXYgCVevzCXdjhmoF6rmnJi7TTZRlUvxzF9DQ6fQtVnX7h55vArf9d7mC6mw?=
 =?us-ascii?Q?xRWjQrOOfmT8oJ1S8YGuNFeldzoDqpJJudbNJX+jaGvtHGnteKDnUUTl1seK?=
 =?us-ascii?Q?XR/rsawQ5eHVS0DaZSJNG6+CN8U/8g4Csy2Uhka87XPg+/DTiHhn3GJPd5BL?=
 =?us-ascii?Q?HHQ9qavCauWO0PpiHvjC7M4D/7b3i6mlbv5qXNUli2muVI9Um+ZOahIwkNLV?=
 =?us-ascii?Q?pjFp+DnCisCUAfL7F72wVmqwdER5yeRUx1UiNxCgyx4H9bBs3hw+AAC5jfY4?=
 =?us-ascii?Q?YJzMftuv9nZ5fsxwYiMakQW105IUS1Y1Y4G+l0c7pnGdpIvOCCL6WGafst5p?=
 =?us-ascii?Q?pYfQljx2KVw54GAYMlOSQrv39eK1HvclPXVmjQdMjMtLNPLqpQsubf/6FuyV?=
 =?us-ascii?Q?rbJ9HFiQWLpq6zOscIRv7yTw0Rnb9yuBBpM0TwH8muQFwjO+OktM0RH/Q5La?=
 =?us-ascii?Q?J6HE0FquB4W28163YwS3jD77iO4+KIEBHH/YLkW2DGHZQCRXAeFgXtrkRS8C?=
 =?us-ascii?Q?B8RPkdY94F+v9/gIvY8Uvvio4OjS/ImWslphN7VUO0CcSU5SUNGL7a+dd/u4?=
 =?us-ascii?Q?+kLQEZ3l0WjNCF1YfCxq8Z31REc/5NFucIru7p2zewkaUahGF2cwGtAhMjJI?=
 =?us-ascii?Q?zRiu1Y948poRv+VSbcXcvTTQ1WSGjQFF3zb39MgKn2itSVYRR765uVFhHekp?=
 =?us-ascii?Q?CS17ThlXDPZ6KiqGFaZv/XZil43RA+kZi2HiORvFyjaFRZFq36YMOZWKWS+K?=
 =?us-ascii?Q?tF1i1ieKlNV3E22HL6rrT0XJtxyi8wUVlqLmjpM+k/HLwV87p7pw+KXFsaGe?=
 =?us-ascii?Q?VStvxVnSvobLCMSVF7oPlGMHqXz6Oj10iro9MoQ3jl2q9V1hZwqXEs5rCKUh?=
 =?us-ascii?Q?Xuxxyn+wQ+qB602zXVLnDW72g+8P++LVGv4x6VmU4YTo5xHXBAQrvR2dIr2Z?=
 =?us-ascii?Q?pvyHcoTSgHrEHrpxqsgiDxqSA8jnFASmBHxzTqBj81rosPrXPM/0GgCNpg4Z?=
 =?us-ascii?Q?++SidDTg+ra+d9ZQOfLN3X1a999JUEH4L5qj5EpUPSqtd/I3qAb7n3x0MXo2?=
 =?us-ascii?Q?8IIfQxr91L9hABXMCCNpO3+NVtNwUGJh25fL2AsI1tCOgzKfCRASYLjiaIrw?=
 =?us-ascii?Q?fV+4hfaiFc3j24EENLsX/YH8CHRYEy+l6Kng5HvLxk+u8tjNpal2fFz+ox83?=
 =?us-ascii?Q?KyVwTJYHsAlYH6raphePSMpA9L2jL3T6EzqndhXZiblDZIEoQ2PdCaF4FBd5?=
 =?us-ascii?Q?iMXoFXWZ3A9e1qWIig6dbtbo3H6wXaT45dTLmE+tNgYjcch2GEuObtz/ynUh?=
 =?us-ascii?Q?IVke0cXqgpCIlrRRPhbjK6EEj1vVX5jptbCgnuAQtRIRVFzL2x9HJ2mHK9v+?=
 =?us-ascii?Q?zs9XTHMTXCIQWKQVs5AKaQ0vfMWr/muvdZdO1mLS8JkCdbwu9+Hp+VaKd2FQ?=
 =?us-ascii?Q?HzJ12kkxhXWB01mXXBDDrrmvF4XJunmmhNmrPv3/mBD68H3wsURd+0CCSX0O?=
 =?us-ascii?Q?k5E800IhaCPvkHCL0m8s30w2QcxQU7B7Pm+qy9vx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kraIuUqVrj2A75/iBfhChSoawoTLx9wnssv7vloG+MJBs6HB0PyIzSQDjCVge1/ERYScHRPPuWQnX/ZRV2aRHNuyx/p9UJXFht8dbb3/B+Lj+Fn7LGOJGvuUo8DXMYP329jQ71GKDNja7L/LYl9sMHLwR6l7D+eG4l6aDLPwoIT6U2nbwYroOAwfFC6W/1Js+W48FF7/HY7sbacPzFoW5Aqav1sXIFxy5CXpU9p/Xy/KOI9SSkI7FXzbjUGBGBDjenQslNOiRNlscD23u59MlCPi8ix6+cLwRIEEjYI+ro6nY2mLgO0zJXwYmgY/wUiyWoc6H0p+l+pYlPH+f8L5ZxhBNsRwZLMlX/bgVAMIPDo730gQ44ADfoZ6MRBr75GdLtbSuqcfbUZ1KLioxnE+wSePqOITVJthmqhNrp28s8ziaLzWHIll3a7HQKq4PX2A7haaDHp6tPLoIrNd6vWXxeHikp122sqF54SH85QF2fjSUUqcYRfAMJyxc9FQB4A6awPTq51Vjz9nXdvL7OlyCZ4AH6WZ1hDIw4bjY5L0VcQ3b9if3K6+sd6/zsfql1gG4rocOMQbEf5MJHDTQV0n8l+C7JGbDN/i6xtmvj9wAd4H/75wrb1h7QnRsEF0Tq+u+SKjAQVBIZlr99KzQsVFEg==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 965bc5d5-b603-4c1c-7844-08dc76d11d51
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB7071.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 00:26:09.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB11417
X-Proofpoint-GUID: mdYUDp82VXJZktXM4-JNvNUHkwsm0-WX
X-Proofpoint-ORIG-GUID: mdYUDp82VXJZktXM4-JNvNUHkwsm0-WX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_11,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405180002



On 17 May 2024, at 16:33, Junio C Hamano wrote:

> "Tom Scogland via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Notably both explicitly state that they honor the last `--prefix` opti=
on
>> before the `--add` option in question.  The implementation of
>> `--add-file` seems to have always honored prefix, but the implementati=
on
>> of `--add-virtual-file` does not.
>
> The above is misleading.
>
>     The implementation of `--add-file` has always honored the prefix,
>     while the implementation of `--add-virtual-file` has always ignored=

>     the prefix.
>
> would make it easier to assess how long existing users may have been
> relying on the current behaviour.

Fair, I had no intention to mislead and will reword.

>> Modify archive.c to include the prefix in the path used by
>> `--add-virtual-file` and add checks into
>> the existing add-virtual-file test to verify:
>>
>> * that `--prefix` is honored
>> * that leading path components are preserved
>> * that both work together and separately
>
> Very nice job explaining the chosen design clearly (even though I do
> not necessarily agree with the direction this patch is going).

Thanks for that.  As to the direction, I mentioned earlier adding a diffe=
rent flag, or perhaps marking the filename in some fashion to express tha=
t the prefix should be honored, would you prefer that? It would, as you s=
aid, be much safer in that there's no reason for it to be a breaking chan=
ge. If there's a design you prefer that would result in having an opt-in =
way to get the prefix behavior I wouldn't mind implementing it.

> Also, given that this option was introduced for an explicit purpose
> of using it to write out diagnostics archive file, we should mention
> that this change does not break it in the proposed log message, at
> least.  Of course, we should do so after verifying that is indeed
> the case, and better yet, after verifying that it will be hard for
> future changes to diagnose.c to trigger an unexpected behaviour
> caused by this change [*].

That's a very good point, and thank you for digging into it.

>> Changes since v1:
>> - Revised the commit message style
>> - Added tests for basename/non-basename behavior
>> - Fixed archive.c to use full path for virtual and basename for add-fi=
le
>
> The "changes since v1" section does not belong to the log message
> proper, as v1 never happened as long as readers of "git log" are
> concerned.  It is a very good thing to help reviewers to have below
> the three-dash lines that comes after your sign-off, though.

My apologies, this is my unfamiliarity with GitGitGadget, I'll put inform=
ation like this in the PR description next time, which I think will do th=
at.
